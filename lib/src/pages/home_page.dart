import 'package:flutter/material.dart';
import 'package:verb_selection/src/utils/DB/initialize_DB.dart';
import 'package:verb_selection/src/utils/verb_card.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    dbHelper.initDatabase();
    return Scaffold(
      appBar: AppBar(
        title: Text('Irregular Verbs'),
      ),
      body: verbCard(context),
    );
  }
}
