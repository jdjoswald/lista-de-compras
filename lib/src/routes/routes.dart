import 'package:flutter/material.dart';
import 'package:listadecompras/src/pages/crearobjetos.dart';
import 'package:listadecompras/src/pages/home_pager.dart';
import 'package:listadecompras/src/pages/homepagesq.dart';
import 'package:listadecompras/src/pages/lista_de_comprass.dart';


Map<String,WidgetBuilder > getAplicationRoutes(){

  return <String,WidgetBuilder>{
        // '/':(BuildContext  context )=> Homepager(),
        '/':(BuildContext  context )=> Homepagesq(),
        "listaitem":(BuildContext  context )=> ListaDeArticulos(),
        "avatar":(BuildContext  context )=> ListaDeArticulos(),
        "card":(BuildContext context)=>ListaDeArticulos(),
        "crearobjeto": (BuildContext context)=>Crearobjetos(),
        
      };
}