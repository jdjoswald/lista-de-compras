import 'package:flutter/material.dart';
class CrearObjeto extends StatelessWidget {
  
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
    );
  }
  _crearinput() {
    return Column(
      children: <Widget>[
        TextField(
          
          decoration: InputDecoration(
            labelText: "Nombre",
            helperText: "Escribe el nombre de lista que quieres crear",
            suffixIcon: Icon(Icons.list),
            border:OutlineInputBorder(
             borderRadius: BorderRadius.circular(20.0)
            )
          ),
         ),
         TextField(
         
          decoration: InputDecoration(
           //hintText: "Lugar",
            labelText: "Lugar",
            helperText: "Escribe el Link del lugar donde compraras el Articulo",
            suffixIcon: Icon(Icons.place),
            border:OutlineInputBorder(
             borderRadius: BorderRadius.circular(20.0)
            )
          ),
         ),
         TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            //hintText: "Costo",
            labelText: "Costo",
            helperText: "cuanto cuesta el articulo",
            suffixIcon: Icon(Icons.attach_money),
            border:OutlineInputBorder(
             borderRadius: BorderRadius.circular(20.0)
            )
          ),
         ),
         TextField(
          decoration: InputDecoration(
            //hintText: "Costo",
            labelText: "Costo",
            helperText: "cuanto cuesta el articulo",
            suffixIcon: Icon(Icons.attach_money),
            border:OutlineInputBorder(
             borderRadius: BorderRadius.circular(20.0)
            )
          ),
         ),
         DropdownButtonFormField(
           items: null , 
           onChanged: null,
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
}