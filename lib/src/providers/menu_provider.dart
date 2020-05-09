import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class _MenuProvider {
  List<dynamic>opciones=[];
  _MenuProvider(){
    // cargardata();
      }
    
      Future <List<dynamic>> cargardata() async{
        final resp =await rootBundle.loadString('data/menu_opts.json');
        Map dataMap = json.decode(resp);
        // print(dataMap['rutas']);
        opciones = dataMap['rutas'];
        return opciones;
        
      }
}
final menuProvider = new _MenuProvider();