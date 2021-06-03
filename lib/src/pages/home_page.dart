import 'package:flutter/material.dart';
import 'package:verb_selection/src/utils/DB/initialize_DB.dart';
import 'package:verb_selection/src/utils/verb_card.dart';

final dbHelper = DatabaseHelper.instance;

// reference to our single class that manages the database
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Irregular Verbs'),
      ),
      body: verbCard(),
    );
  }
}
