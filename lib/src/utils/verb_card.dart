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
       child:
       new FutureBuilder<dynamic>(
       future: getMostUsedVerbs(),
       builder: (context, snapshot) {
         if (snapshot.hasData) {
           return ListView.builder(
             padding: EdgeInsets.only(top: 5, bottom: 16),
              //scrollDirection: Axis.horizontal,
               itemCount: snapshot.data.length,
               itemBuilder: (context, index){
                 return Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[

                       new Container(

                         /*height: heightContainer,
                     width: SizeConfig.safeBlockHorizontal * 100,*/
                         padding: EdgeInsets.only(
                             right: 10, left: 10, bottom: 10),
                         margin: const EdgeInsets.only(left: 10.0, right: 10.0,),
                         //    padding: EdgeInsets.only(top: 2, right: 10, bottom: 10, left: 10),
                         //height: 150,
                         decoration: BoxDecoration(
                             color: Colors.white70,
                             borderRadius: BorderRadius.circular(12),
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey,
                                 offset: Offset(1, 1),
                                 blurRadius: 5,
                               ),
                             ]),

                         child: Center(
                           child: Column(
                             children: <Widget>[
                               SizedBox(height: 10),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment
                                     .spaceBetween,
                                 mainAxisSize: MainAxisSize.min,
                                 verticalDirection: VerticalDirection.down,

                                 children: <Widget>[
                                   VerticalDivider(
                                     width: 5,
                                   ),

                                   ElevatedButton(
                                     style: ElevatedButton.styleFrom(
                                       padding: EdgeInsets.only(top: 12,
                                           bottom: 12,
                                           right: 26,
                                           left: 28),
                                       elevation: 5,
                                       //primary: col,
                                       onPrimary: Colors.white,
                                       shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(
                                               30)),
                                       alignment: Alignment.center,
                                     ),
                                     child: new Text(
                                       snapshot.data[index]['description'].toString(),
                                       textAlign: TextAlign.center,
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontSize: 15,
                                       ),
                                     ),
                                     onPressed: () {},

                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),
                     ]
                 );
               }
             //children: <Widget>[

             //],

           );
         }
         else if (snapshot.hasError) {
           return new Text("${snapshot.error}");
         }
         return new Container(
           alignment: AlignmentDirectional.center,
           child: new CircularProgressIndicator(),
         );
       }
     ),
  ),
 );
}
  
