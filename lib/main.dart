import 'package:flutter/material.dart';
import 'package:listadecompras/src/pages/home_pager.dart';
import 'package:listadecompras/src/routes/routes.dart';


 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  // ListaDatabase db = ListaDatabase();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'componentes app',
      initialRoute: '/',
      routes: getAplicationRoutes(),

      onGenerateRoute: (RouteSettings settings){
          return MaterialPageRoute(
          builder: (BuildContext context)=> Homepager()
          );
      },
      );
    
  }
}
