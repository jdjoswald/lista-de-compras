import 'package:flutter/material.dart';
import 'package:listadecompras/src/database/database.dart';

class Homepagesq extends StatefulWidget {
  @override
  _HomepagesqState createState() => _HomepagesqState();
}

class _HomepagesqState extends State<Homepagesq> {
  ListaDatabase db = ListaDatabase();
  List<String> _lista=[];
  String _nombre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title:Text("prueba")),
      body: FutureBuilder(
        future:db.initDB() ,
        builder: (BuildContext,snapshot){
          if (snapshot.connectionState == ConnectionState.done){
             return _showlist(context);
          }else{
            return Center(
              child : CircularProgressIndicator()
            );
          }
        }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed:  ()=> _crearLista(context),
        child: Icon(Icons.add),
        ),
      
    );
  }
  _showlist(BuildContext context){
    return FutureBuilder(
      future: db.getAlllista(),
      builder: (BuildContext context, AsyncSnapshot<List<Lista>> snapshot){
        return ListView(
              children: <Widget>[
                for(String lista in snapshot.data)ListTile(title: Text(lista.name),)

              ],
            
            );

      }
    );
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
            FlatButton(onPressed: null, child: Text("OK")),
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
}