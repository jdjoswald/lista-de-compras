import 'package:flutter/material.dart';
import 'package:listadecompras/src/providers/icono_string.dart';
import 'package:listadecompras/src/providers/menu_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de compras"),
      ),
      body: _Listasdecompras() ,             
      floatingActionButton: FloatingActionButton(
        onPressed:(){
           Navigator.pushNamed(context, "crearlista");
        } ,

        child: Icon(Icons.add),

      ),
    );
              
  }
          
  Widget _Listasdecompras() {
      return FutureBuilder(
        future:menuProvider.cargardata() ,
        builder: (context,AsyncSnapshot<List<dynamic>> snapshot ){
          return ListView(
              children: _listaItems(snapshot.data, context),
          );
        },
        initialData: [],
      );
  }
  
  List<Widget>_listaItems(List<dynamic>data, BuildContext context) {
      final List<Widget> opciones=[];
      data.forEach((opt){

        final widgetTemp = ListTile(
          title: Text(opt['texto']),
          leading: Geticon(opt["icon"]),
          trailing: Icon(Icons.error),
          onTap: (){
            Navigator.pushNamed(context, opt['ruta']);
           },
        );
        opciones..add(widgetTemp)
                ..add(Divider());


        
      });
      return opciones;
    }
}