import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:verb_selection/src/utils/DB/initialize_DB.dart';

final dbHelper = DatabaseHelper.instance;
int uses;
Widget verbCard() {
  dbHelper.queryMostUsedVerbs();
  dbHelper.queryAllPronouns();
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(child: Text('hola')),
    ],
  ));
}
