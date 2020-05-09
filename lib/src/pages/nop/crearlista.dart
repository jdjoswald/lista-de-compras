import 'package:flutter/material.dart';


class CrearLista  extends StatefulWidget {
  @override
  _CrearListaState createState() => _CrearListaState();
}

class _CrearListaState extends State<CrearLista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear lista"),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(vertical:100.0,horizontal: 15.0),
        children: <Widget>[
          _crearinput()
        ],
      ),
    );
  }

  _crearinput() {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Nombre de lista",
        labelText: "Nombre",
        helperText: "Escribe el nombre de lista que quieres crear",
        suffixIcon: Icon(Icons.list),
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),

    );
  }
}
