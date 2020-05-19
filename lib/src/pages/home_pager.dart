import 'package:flutter/material.dart';
import 'package:listadecompras/src/providers/icono_string.dart';
import 'package:listadecompras/src/providers/menu_provider.dart';

class Homepager extends StatefulWidget {
  @override
  _HomepagerState createState() => _HomepagerState();
}

class _HomepagerState extends State<Homepager> {
  String _nombre="";
  List<int> _alert=[200,300];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de compras"),
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

        final widgetTemp = Dismissible(
          key: ObjectKey(opt), 
          child: ListTile(
          title: Text(opt['texto']),
          leading: Geticon(opt["icon"]),
          trailing: Icon(Icons.arrow_right),
          onTap:(){ Navigator.pushNamed(context, opt['ruta']);}
        ) );
        opciones..add(widgetTemp)
                ..add(Divider());
       


        
      });

      //   final widgetTemp = ListTile(
      //     title: Text(opt['texto']),
      //     leading: Geticon(opt["icon"]),
      //     trailing: Icon(Icons.arrow_right),
      //     onTap:(){ Navigator.pushNamed(context, opt['ruta']);}
      //   );
      //   opciones..add(widgetTemp)
      //           ..add(Divider());


        
      // });
      return opciones;
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