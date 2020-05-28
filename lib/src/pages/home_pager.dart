import 'package:flutter/material.dart';
import 'package:listadecompras/src/database/database.dart';
import 'package:listadecompras/src/providers/icono_string.dart';
import 'package:listadecompras/src/providers/menu_provider.dart';
import "package:flutter_slidable/flutter_slidable.dart";

import 'lista_de_comprass.dart';


class Homepager extends StatefulWidget {
  @override
  _HomepagerState createState() => _HomepagerState();
}

class _HomepagerState extends State<Homepager> {
  Shoplistdb db = Shoplistdb();
  String _nombre="";
  List<int> _alert=[200,300];
  List<String>listas=["KLK"];
   int id=1;
  @override
  Widget build(BuildContext context) {
    db.InitDB();
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de compras"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh, color: Colors.white,), onPressed:()=>refresh()),// ()=> _search(context),
          IconButton(icon: Icon(Icons.attach_money, color: Colors.white,), onPressed: ()=> _precio(context),),
          IconButton(icon: Icon(Icons.info, color: Colors.white,), onPressed: ()=> _help(context), )
        ],
      ),
      body: _listaItems(context), 
                  
      floatingActionButton: FloatingActionButton(
        onPressed: 
          ()=> _crearLista(context),
        child: Icon(Icons.add),
      ),
    );             
  }

          
  Widget _Listasdecompras() {
      return FutureBuilder(
        future:db.InitDB(),
        builder: (BuildContext context, snapshot ){
          if (snapshot.connectionState == ConnectionState.done){
          return RefreshIndicator(  
          onRefresh: refresh,
          child:ListView(
              children: _listaItems(context),
           ));
          }
          else{
           return Center(child: Text("data"));
          }
          
        },
      );
  }

  
  _listaItems( BuildContext context) {
    return FutureBuilder(
        future: db.getAllLists(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
      if (snapshot.hasData== true){    
          return(RefreshIndicator(  
          onRefresh: refresh,
          child:
            ListView(
              children:_listas(snapshot.data, context)))
          );
      }

    else{
      return Center(
      child: Text("agrega tarea"),
    );
    }  
  });}
     
    Future<Null> refresh()async{
       setState(() {
        }); 
        return null;   

    }


  void _crearLista(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          title: Text("Crear lista"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content:Column(
            mainAxisSize: MainAxisSize.min, 
            children: <Widget>[
              Container(
                width:2000000.0,
                height:2.0,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
              ),
              _crearinput(),
            ],
          ),
          actions: <Widget>[
            FlatButton(onPressed: ()=>Nuevalista() , child: Text("OK")),
            FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Cancelar")),
          ],
        );
      }
    );
  }


  Widget _crearinput() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Nombre",
        helperText: "escribe el nombre de la nueva lista",
        icon: Icon(Icons.list),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onChanged: (valor){
        setState(() {
          _nombre=valor;
        });               
      },           
    );
  }


  _help(BuildContext context) {
    showDialog( 
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          title: Text("Ayuda pagina de Lista de compras"),
          content: Column(
            mainAxisSize: MainAxisSize.min, 
            children: <Widget>[  
              Text("En esta pantalla puede ver una lista de todas las listas de compras un swippe a la izquierda abre una lista de botones en donde podra elimnarla o editar el nombre"),
              Divider(),
              Text("En el boton + puede añadir otra lista")              
            ],
          ),
          actions: <Widget>[
            FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("OK")),
          ],
        );
      }
    );
  }


  _precio(BuildContext context) {
    showDialog( 
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          title: Text("precio dolar"),
          content: Column(
            mainAxisSize: MainAxisSize.min, 
            children: <Widget>[  
             _crearinput2(),
            ],
          ),
           actions: <Widget>[
            FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("OK")),
          ],
        );
      }
    );
  }


  Widget _crearinput2() {
    return TextField(
      decoration: InputDecoration(
        labelText: "precio actual del dolar",
        helperText: "ingrese el precio actual del dolar",
        icon: Icon(Icons.attach_money, color: Colors.blue,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      // onChanged: (valor){
      //   setState(() {
      //     _nombre=valor;
      //   });               
      // },           
    );
  }
   Nuevalista(){
     if(_nombre!=""){
     Map <String , dynamic  >nuevo= {"name": _nombre} ;
     db.insert(nuevo);
     _nombre="";
     Navigator.of(context).pop();
     setState(() {
        });
     }
   }

  List<Widget> _listas(List<Map> data, BuildContext context) {
    final List<Widget> items=[];
    data.forEach((opt) { 

       final widgetTemp =Slidable(
         actionPane: SlidableBehindActionPane(),
         secondaryActions: <Widget>[
            FlatButton(
              color: Colors.red,
              onPressed: ()=>Borrar(opt["id"]), 
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(4.0)),
                  Icon(Icons.delete),
                  Text("Borrar" ,
                        style:TextStyle(
                        //  backgroundColor: Colors.red
                        )
                  )
                ],
              )
            ),
            FlatButton(
              color: Colors.green,
              onPressed: () => _crearLista(context), 
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(4.0)),
                  Icon(Icons.edit),
                  Text("Editar" ,
                        style:TextStyle(
                        //  backgroundColor: Colors.red
                        )
                  )
                ],
              )
            )
          ],
         child :ListTile(
           title: Text( opt["name"]),
           leading: Icon(Icons.list),
          //  leading: Text( opt["id"].toString()),
          //  leading: Text("$id"),
           trailing: Icon(Icons.arrow_right),
           onTap:(){
             var route =new MaterialPageRoute(
              builder: (BuildContext context)=>new ListaDeArticulos(idl: opt["id"],nombrel:opt["name"])
             );
               Navigator.of(context).push(route);
          }
        ));

       items..add(widgetTemp)
              ..add(Divider()); 
    });
     return items;
  }

  void Borrar(int id ) {
    db.deletelist(id);
    refresh();
  }
  
}


  // final List<Widget> opciones=[];
    // // data.forEach((opt)
    // for (String lista in listas){
    //   final widgetTemp = Dismissible(
    //     key: ObjectKey(lista), 
    //     child:  ListTile(
    //         title: Text(lista),
    //         leading: Icon(Icons.list),
    //         trailing: Icon(Icons.arrow_right),
    //         onTap:(){ Navigator.pushNamed(context, "listaitem");}
          
    //     )
    //   );
    //   opciones..add(widgetTemp)
    //             ..add(Divider());
    //   };
    //   return opciones;