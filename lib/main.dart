import 'package:flutter/material.dart';
import 'package:verb_selection/src/pages/home_page.dart';
import 'package:verb_selection/src/routes/routes.dart';
import 'package:verb_selection/src/utils/DB/initialize_DB.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Irregular Verbs',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
       home: HomePage()
      /*routes: getAplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        print('ruta llamada: ${settings.name}');
        return MaterialPageRoute(builder: (BuildContext context) => HomePage());
      },*/
    );
  }
}
