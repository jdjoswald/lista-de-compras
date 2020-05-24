import 'package:flutter/material.dart';
import 'package:listadecompras/src/database/database.dart';
import 'package:listadecompras/src/providers/icono_string.dart';
import 'package:listadecompras/src/providers/menu_provider.dart';


class Homepager extends StatefulWidget {
  @override
  _HomepagerState createState() => _HomepagerState();
}

class _HomepagerState extends State<Homepager> {
  Shoplistdb db = Shoplistdb();
  String _nombre="";
  List<int> _alert=[200,300];
  List<String>listas=["KLK"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de compras"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: null),// ()=> _search(context),
          IconButton(icon: Icon(Icons.attach_money, color: Colors.white,), onPressed: ()=> _precio(context),),
          IconButton(icon: Icon(Icons.info, color: Colors.white,), onPressed: ()=> _help(context), )
        ],
      ),
      body: _Listasdecompras() ,             
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
              children: _listaItems(snapshot, context),
          ));
          }
          else{
            return Center(
              child: CircularProgressIndicator()
            );
          }
          
        },
      );
  }

  
  List<Widget>_listaItems(AsyncSnapshot data, BuildContext context) {
    final List<Widget> opciones=[];
    // data.forEach((opt)
    for (String lista in listas){
      final widgetTemp = Dismissible(
        key: ObjectKey(lista), 
        child:  ListTile(
            title: Text(lista),
            leading: Icon(Icons.list),
            trailing: Icon(Icons.arrow_right),
            onTap:(){ Navigator.pushNamed(context, "listaitem");}
          
        )
      );
      opciones..add(widgetTemp)
                ..add(Divider());
      };
      return opciones;
    }
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
     listas.add(_nombre);
     _nombre="";
     Navigator.of(context).pop();
     }
   }
}