import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:verb_selection/src/utils/DB/initialize_DB.dart';

final dbHelper = DatabaseHelper.instance;

Future getMostUsedVerbs() async {
  final mostUsedVerbs = await dbHelper.queryMostUsedVerbs();
  print(mostUsedVerbs);
  return mostUsedVerbs;
}

Widget verbCard(BuildContext context) {
  dbHelper.initDatabase();
  /*dbHelper.queryMostUsedVerbs();
  dbHelper.queryAllPronouns();*/
  //dbHelper.queryMostUsedVerbs1();

  return new Container(
    padding: new EdgeInsets.all(16.0),
    child: new FutureBuilder<dynamic>(
      future: getMostUsedVerbs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new ElevatedButton(
                        onPressed: () {},
                        child: new Text(
                          snapshot.data[index]['description'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Myfont',
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      new Text(snapshot.data[index]['uses'].toString(),
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      new Text(snapshot.data[index]['description'].toString(),
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0)),
                      new Divider()
                    ]);
              });
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new Container(
          alignment: AlignmentDirectional.center,
          child: new CircularProgressIndicator(),
        );
      },
    ),
  );
}