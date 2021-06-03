import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "abaton.db";
  static final _databaseVersion = 1;

  static final verbs = 'verbs';
  static final columnIdVerbs = 'id_verb';
  static final columnDescriptionVerbs = 'description';
  static final columnUsesVerbs = 'uses';
  static final columnFkIdLetterVerbs = 'fk_id_letter';

  static final pronouns = 'pronouns';
  static final columnIdPronouns = 'id_pronoun';
  static final columnDescriptionPronouns = 'description';
  static final columnUsesPronouns = 'uses';

  static final phrases = 'phrases';
  static final columnIdPhrases = 'id_phrase';
  static final columnFkIdPronoun = 'fk_id_pronoun';
  static final columnFkIdVerb = 'fk_id_verb';
  static final columnPhrase = 'phrase';

  static final listVerbs = 'listVerbs';
  static final columnIdListVerbs = 'id_letter';
  static final columnLetterListVerbs = 'letter';
  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $verbs (
            $columnIdVerbs INTEGER PRIMARY KEY,
            $columnDescriptionVerbs TEXT NOT NULL,
            $columnUsesVerbs REAL NOT NULL,
            $columnFkIdLetterVerbs INTEGER NOT NULL,
            FOREIGN KEY($columnFkIdLetterVerbs) 
            REFERENCES $listVerbs($columnIdListVerbs)
          )
          ''');

    await db.execute('''
          CREATE TABLE $listVerbs (
            $columnIdListVerbs INTEGER PRIMARY KEY,
            $columnLetterListVerbs TEXT NOT NULL,
          )
          ''');

    await db.execute('''
          CREATE TABLE $pronouns (
            $columnIdPronouns INTEGER PRIMARY KEY,
            $columnDescriptionPronouns TEXT NOT NULL,
            $columnUsesPronouns REAL NOT NULL,
          )
          ''');

    await db.execute('''
          CREATE TABLE $phrases (
            $columnIdPhrases INTEGER PRIMARY KEY,
            $columnPhrase TEXT NOT NULL,
            $columnFkIdPronoun REAL NOT NULL,
            $columnFkIdVerb REAL NOT NULL,
            FOREIGN KEY($columnFkIdPronoun) 
            REFERENCES $pronouns($columnIdPronouns),
            FOREIGN KEY($columnFkIdVerb) 
            REFERENCES $verbs($columnIdVerbs)
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertVerb(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(verbs, row);
  }

  Future<int> insertPhrase(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(phrases, row);
  }

  Future<int> insertPronoun(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(pronouns, row);
  }

  Future<int> insertListVerb(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(listVerbs, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRowsVerbs() async {
    Database db = await instance.database;
    return await db.query(verbs);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsPhrases() async {
    Database db = await instance.database;
    return await db.query(phrases);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsPronouns() async {
    Database db = await instance.database;
    return await db.query(pronouns);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsListVerbs() async {
    Database db = await instance.database;
    return await db.query(listVerbs);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $verbs'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> updateVerb(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdVerbs];
    return await db.update(verbs, row[columnDescriptionVerbs],
        where: '$columnIdVerbs = ?', whereArgs: [id]);
  }

  Future<int> updatePronoun(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdPronouns];
    return await db.update(pronouns, row[columnDescriptionPronouns],
        where: '$columnIdPronouns = ?', whereArgs: [id]);
  }

  Future<int> updateListVerb(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIdListVerbs];
    return await db.update(pronouns, row[columnLetterListVerbs],
        where: '$columnIdPronouns = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> deleteVerb(int id) async {
    Database db = await instance.database;
    return await db.delete(verbs, where: '$columnIdVerbs = ?', whereArgs: [id]);
  }

  Future<int> deletePronoun(int id) async {
    Database db = await instance.database;
    return await db
        .delete(verbs, where: '$columnIdPronouns = ?', whereArgs: [id]);
  }
}