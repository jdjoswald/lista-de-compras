import 'package:flutter/material.dart';
// import 'package:listadecompras/src/providers/icono_string.dart';
import 'package:listadecompras/src/providers/ltem_provider.dart';
// import 'package:listadecompras/src/providers/menu_provider.dart';

class ListaDeArticulos extends StatefulWidget {
  @override
  _ListaDeArticulosState createState() => _ListaDeArticulosState();
}

class _ListaDeArticulosState extends State<ListaDeArticulos> {
  bool comprado= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("lista inserte nombre"),
      ),

      body: _lista() ,

      floatingActionButton: FloatingActionButton(
       
        onPressed:(){
          Navigator.pushNamed(context,"crearobjeto");
        } ,

        child: Icon(Icons.add),
      ),

      
    );
    
  }
   Widget _lista() {
      return FutureBuilder(
        future:itemProvider.cargardata() ,
        builder: (context,AsyncSnapshot<List<dynamic>> snapshot ){

          return ListView(
              children: _listaItems(snapshot.data, context),
          );

        },
        initialData: [],
      );
    }
       
    List<Widget>_listaItems(List<dynamic>data, BuildContext context) {
      final List<Widget> items=[];
      data.forEach((opt){
        int precio=opt['precio'];
        
        final widgetTemp = CheckboxListTile(
          
          title: Row (
            children: <Widget>[
              Text(opt['articulo']),
              Expanded(
            flex: 2,
            child: Container(
              height: 1,
            ),
          ),
              Text(" $precio ")],
          ),
          value:opt["estado"],
          secondary: RaisedButton(onPressed:()=> Navigator.pushNamed(context,"crearobjeto"), child: Icon(Icons.edit,color:Colors.blue,)),
          onChanged: (valor){
             setState(() {

              comprado=valor;
             });  
          }, 
        );
        items..add(widgetTemp)
                ..add(Divider());


        
      });
      return items;
    }

  void _editarBorrar(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){

        return AlertDialog(
          title: Text("editar borrar"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content:Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("klk menol"),
              FlutterLogo(size: 100.0,)
            ],
          ),
          actions: <Widget>[
            FlatButton(onPressed: null, child: Text("OK")),
            FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Cancelar")),
            // FlatButton(
            //   onPressed: ()=>Navigator.of(context).pop(), 
            
            //   child: Text("si pero no")
            // ),

          ],
        );
      }
    );
  }
}