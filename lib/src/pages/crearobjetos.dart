import 'package:flutter/material.dart';
class Crearobjetos extends StatefulWidget {
  @override
  _CrearobjetosState createState() => _CrearobjetosState();
}

class _CrearobjetosState extends State<Crearobjetos> {
  List<String> _poderes=["Dolar","Peso"];
  String _opcionSeleccionada= "Peso";
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text("Crear Objeto"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical:50.0,horizontal: 15.0),
        children: <Widget>[
          _crearinput()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), 
        onPressed: null,
      ),
    );
  }
  _crearinput() {
    return Column(
      children: <Widget>[
        
        TextField(
          decoration: InputDecoration(
            labelText: "Nombre",
            helperText: "Escribe el nombre del producto que quieres crear",
            suffixIcon: Icon(Icons.list),
            border:OutlineInputBorder(
             borderRadius: BorderRadius.circular(20.0)
            )
          ),
         ),

         Divider(),
         TextField(
          keyboardType: TextInputType.url,
          decoration: InputDecoration(
            labelText: "url",
            helperText: "Escribe el Link del lugar donde compraras el Articulo",
            suffixIcon: Icon(Icons.place),
            border:OutlineInputBorder(
             borderRadius: BorderRadius.circular(20.0)
            )
          ),
         ),

         Divider(),
         TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Costo",
            helperText: "cuanto cuesta el articulo",
            suffixIcon: Icon(Icons.attach_money),
            border:OutlineInputBorder(
             borderRadius: BorderRadius.circular(20.0)
            )
          ),
         ),

         Divider(),
         DropdownButtonFormField(
           value: _opcionSeleccionada,
           items: getOpcionnesDropdwn(),  
            onChanged: (opt){
            setState(() {
              _opcionSeleccionada=opt;
              });
            },
           decoration: InputDecoration(
            labelText: "Divisa",
            helperText: "En que divisa esta el articulo recuerda cambiar el valor de divisas",
            suffixIcon: Icon(Icons.attach_money),
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0)
            )
           ),
           
           
         ),
      ],
    );
    
  }
  List<DropdownMenuItem<String>> getOpcionnesDropdwn(){
    List<DropdownMenuItem<String>>lista = new List();
    _poderes.forEach((poder){
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));

    });
    return lista;
  }
}