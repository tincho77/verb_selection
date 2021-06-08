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

  return SafeArea(
    child: Container(
      child: new FutureBuilder<dynamic>(
          future: getMostUsedVerbs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                      GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          padding: EdgeInsets.only(top: 25.0),
                          childAspectRatio: 3 / 2,
                          children:
                              List.generate(snapshot.data.length, (index) {
                            if (snapshot.data[index]['description']
                                    .toString() !=
                                null) {
                              return Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                verticalDirection: VerticalDirection.down,
                                children: <Widget>[
                                  VerticalDivider(
                                    width: 5,
                                    color: Colors.white12,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.only(
                                          top: 12,
                                          bottom: 12,
                                          right: 18,
                                          left: 22),
                                      elevation: 5,
                                      //primary: col,
                                      onPrimary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      alignment: Alignment.center,
                                    ),
                                    child: new Text(
                                      snapshot.data[index]['description']
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ));
                            } else {
                              return Container(
                                //color: Colors.blue,
                                margin: EdgeInsets.all(10.0),
                              );
                            }
                          })),
                      Align(
                        alignment: Alignment(0.8, -1.0),
                        heightFactor: 0.5,
                        child: FloatingActionButton(
                          onPressed: null,
                          child: Icon(Icons.add),
                        ),
                      )
                    ])),
              ));
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return new Container(
              alignment: AlignmentDirectional.center,
              child: new CircularProgressIndicator(),
            );
          }),
    ),
  );
}
