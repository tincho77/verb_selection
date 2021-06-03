import 'package:flutter/material.dart';
import 'package:verb_selection/src/utils/DB/initialize_DB.dart';
import 'package:verb_selection/src/utils/verb_card.dart';

// reference to our single class that manages the database
class HomePage extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    dbHelper.initDatabase();
    return Scaffold(
      appBar: AppBar(
        title: Text('Irregular Verbs'),
      ),
      body: verbCard(),
    );
  }
}
