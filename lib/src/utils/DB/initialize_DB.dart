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
    _database = await initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print('DB location: ' + documentsDirectory.path);
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $listVerbs (
            $columnIdListVerbs INTEGER NOT NULL,
            $columnLetterListVerbs TEXT NOT NULL,
            PRIMARY KEY($columnIdListVerbs AUTOINCREMENT)
          )
          ''');

    await db.execute('''
          CREATE TABLE $verbs (
            $columnIdVerbs INTEGER NOT NULL,
            $columnDescriptionVerbs TEXT NOT NULL,
            $columnUsesVerbs INTEGER NOT NULL,
            $columnFkIdLetterVerbs INTEGER NOT NULL,
            PRIMARY KEY($columnIdVerbs AUTOINCREMENT),
            FOREIGN KEY($columnFkIdLetterVerbs) 
            REFERENCES $listVerbs($columnIdListVerbs)
          )
          ''');

    await db.execute('''
          CREATE TABLE $pronouns (
            $columnIdPronouns INTEGER NOT NULL,
            $columnDescriptionPronouns TEXT NOT NULL,
            $columnUsesPronouns INTEGER NOT NULL,
            PRIMARY KEY($columnIdPronouns AUTOINCREMENT)
          )
          ''');

    await db.execute('''
          CREATE TABLE $phrases (
            $columnIdPhrases INTEGER NOT NULL,
            $columnPhrase TEXT NOT NULL,
            $columnFkIdPronoun INTEGER NOT NULL,
            $columnFkIdVerb INTEGER NOT NULL,
            PRIMARY KEY($columnIdPhrases AUTOINCREMENT),
            FOREIGN KEY($columnFkIdPronoun) 
            REFERENCES $pronouns($columnIdPronouns),
            FOREIGN KEY($columnFkIdVerb) 
            REFERENCES $verbs($columnIdVerbs)
          )
          ''');

    await db.execute(''' 
        INSERT INTO $listVerbs($columnLetterListVerbs)
        VALUES
              ('a'), ('b'), ('c'), ('d'), ('e'), ('f'), ('g'), ('h'), ('i'),
              ('j'), ('k'), ('l'), ('ll'), ('m'), ('n'), ('ñ'), ('o'), ('p'),
              ('q'), ('r'), ('s'), ('t'), ('u'), ('v'), ('w'), ('k'), ('y'),
              ('z');
        ''');

    /* --------------------------        --------------------------  */

    // insert letter 'A'
    await db.execute('''
        INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
        , $columnFkIdLetterVerbs)
        VALUES 
           ('abrir',0,1), ('acabar',0,1), ('acercar',0,1), ('aconsejar',0,1),
           ('acordar',0,1), ('amar',0,1), ('andar',0,1), ('apoyar',0,1),
           ('aprender',0,1), ('armar',0,1), ('asesinar',0,1), ('atacar',0,1),
           ('ayudar',0,1);
        ''');

    // insert letter 'B'
    await db.execute('''
        INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
        , $columnFkIdLetterVerbs)
        VALUES 
           ('bailar',0,2), ('bajar',0,2), ('bastar',0,2), ('bañar',0,2),
           ('beber',0,2), ('buscar',0,2);
        ''');

    // insert letter 'C'
    await db.execute('''
        INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
        , $columnFkIdLetterVerbs)
        VALUES 
           ('caer',0,3), ('callar',0,3), ('calmar',0,3), ('cambiar',0,3),
           ('caminar',0,3), ('campar',0,3), ('cantar',0,3), ('cazar',0,3),
           ('cenar',0,3), ('centrar',0,3), ('cercar',0,3), ('cerrar',0,3),
           ('citar',0,3), ('cocinar',0,3), ('coger',0,3), ('comenzar',0,3),
           ('comer',0,3), ('comparar',0,3), ('comprar',0,3), ('conducir',0,3),
           ('conocer',0,3), ('conseguir',0,3), ('conseguir',0,3), ('continuar',0,3),
           ('correr',0,3), ('cortar',0,3), ('coser',0,3), ('costar',0,3),
           ('crear',0,3), ('creer',0,3), ('cuidar',0,3), ('culpar',0,3);
        ''');

    // insert letter 'D'
     await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('dar',0,4), ('dañar',0,4), ('deber',0,4), ('decidir',0,4),
             ('decir',0,4), ('dejar',0,4), ('descansar',0,4), ('describir',0,4),
             ('desear',0,4), ('destruir',0,4), ('disculpar',0,4), ('divertir',0,4),
             ('doler',0,4), ('dormir',0,4), ('durar',0,4);
        ''');

    // insert letter 'E'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('elegir',0,5),('empezar',0,5),('empujar',0,5),('encantar',0,5),
             ('encontrar',0,5),('enseñar',0,5),('entender',0,5),('entrar',0,5),
             ('equipar',0,5),('esconder',0,5),('escribir',0,5),('escuchar',0,5),
             ('esperar',0,5),('esposar',0,5),('estar',0,5),('estudiar',0,5),
             ('existir',0,5),('explicar',0,5),('extrañar',0,5);
        ''');

    // insert letter 'F'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('faltar',0,6),('forzar',0,6),('funcionar',0,6);
        ''');

    // insert letter 'G'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('ganar',0,7),('gritar',0,7),('gustar',0,7);
        ''');

    // insert letter 'H'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('haber',0,8),('hablar',0,8),('hacer',0,8);
        ''');

    // insert letter 'I'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('importar',0,9),('intentar',0,9),('ir',0,9);
        ''');

    // insert letter 'J'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('jugar',0,10),('jurar',0,10);
        ''');

    // insert letter 'L'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('lamentar',0,12),('lanzar',0,12),('largar',0,12),('lavar',0,12),
             ('leer',0,12),('limpiar',0,12),('luchar',0,12);
        ''');

    // insert letter 'LL'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('llamar',0,13),('llegar',0,13),('llenar',0,13),('llevar',0,13),
             ('llorar',0,13);
        ''');

    // insert letter 'M'
     await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('mandar',0,14),('matar',0,14),('mejor',0,14),('mejorar',0,14),
             ('mentir',0,14),('mirar',0,14),('morir',0,14),('mostrar',0,14),
             ('mover',0,14);
        ''');

    // insert letter 'N'
     await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('necesitar',0,15),('negociar',0,15),('nombrar',0,15);
        ''');

    // insert letter 'O'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('ocurrir',0,17),('odiar',0,17),('ofrecer',0,17),('olvidar',0,17),
             ('orar',0,17),('oír',0,17);
        ''');

    // insert letter 'P'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('pagar',0,18),('parar',0,18),('parecer',0,18),('partir',0,18),
             ('pasar',0,18),('pelar',0,18),('pelear',0,18),('peligrar',0,18),
             ('penar',0,18),('pensar',0,18),('perder',0,18),('perdonar',0,18),
             ('permitir',0,18),('pisar',0,18),('poder',0,18),('poner',0,18),
             ('preferir',0,18),('preguntar',0,18),('preocupar',0,18),('preparar',0,18),
             ('probar',0,18),('prometer',0,18),('pulsar',0,18);
        ''');

    // insert letter 'Q'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('quedar',0,19),('quemar',0,19),('querer',0,19);
        ''');

    // insert letter 'R'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('recibir',0,20),('reconocer',0,20),('recordar',0,20),('regalar',0,20),
             ('regresar',0,20),('repetir',0,20),('responder',0,20),('reír',0,20);
        ''');

    // insert letter 'S'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('saber',0,21),('sacar',0,21),('salir',0,21),('saltar',0,21),
             ('salvar',0,21),('seguir',0,21),('sentar',0,21),('sentir',0,21),
             ('ser',0,21),('significar',0,21),('sonar',0,21),('sonreír',0,21),
             ('sostener',0,21),('soñar',0,21),('suceder',0,21),('suponer',0,21);
        ''');

    // insert letter 'T'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('tardar',0,22),('temer',0,22),('tener',0,22),('terminar',0,22),
             ('tirar',0,22),('tocar',0,22),('tomar',0,22),('trabajar',0,22),
             ('traer',0,22),('tratar',0,22);
        ''');

    // insert letter 'U'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('usar',0,23),('unir',0,23);
        ''');

    // insert letter 'V'
    await db.execute('''
          INSERT INTO $verbs ($columnDescriptionVerbs, $columnUsesVerbs
          , $columnFkIdLetterVerbs)
          VALUES 
             ('valer',0,24),('vender',0,24),('venir',0,24),('ver',0,24),
             ('viajar',0,24),('visitar',0,24),('vivir',0,24),('volver',0,24);
        ''');

    /* --------------------------        --------------------------  */

    // insert Pronouns
    await db.execute('''
          INSERT INTO $pronouns ($columnDescriptionPronouns, $columnUsesPronouns)
          VALUES 
             ('yo',0),('tu',0),('el',0),('ella',0), ('ellos',0),
             ('ellas',0),('nosotros',0),('nosotras',0),('ustedes',0);
        ''');

  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
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

  // ------------------------ Consultas SQL -------------------------------

  Future<dynamic> queryMostUsedVerbs() async {
    Database db = await instance.database;

    var result = await db.rawQuery(
        '''SELECT $columnUsesVerbs, $columnIdVerbs, $columnDescriptionVerbs
         FROM $verbs ORDER BY $columnUsesVerbs DESC LIMIT 6''');

    if(result.length == 0)
      return null;
    else{
      var resultMap = result.toList();
      //print(resultMap);
      return resultMap.isNotEmpty ? resultMap : Null;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllPronouns() async {
    Database db = await instance.database;

    List<Map> listPronouns = await db.rawQuery(
        '''SELECT $columnUsesPronouns, $columnIdPronouns, $columnDescriptionPronouns
         FROM $pronouns LIMIT 9''');

    print(listPronouns);
    return listPronouns;
  }

  Future dbClose() async {
    Database db = await instance.database;
    await db.close();
  }
}
