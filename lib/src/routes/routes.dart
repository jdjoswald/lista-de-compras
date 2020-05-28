import 'package:flutter/material.dart';
import 'package:listadecompras/src/pages/home_pager.dart';
import 'package:listadecompras/src/pages/lista_de_comprass.dart';


Map<String,WidgetBuilder > getAplicationRoutes(){

  return <String,WidgetBuilder>{
         '/':(BuildContext  context )=> Homepager(),
        "listaitem":(BuildContext  context)=> ListaDeArticulos(),
        
        
      };
}