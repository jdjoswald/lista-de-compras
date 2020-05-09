// import 'package:flutter/material.dart';
// import 'package:listadecompras/src/providers/icono_string.dart';
// import 'package:listadecompras/src/providers/ltem_provider.dart';
// import 'package:listadecompras/src/providers/menu_provider.dart';


// class  ListaDeArticulos extends StatelessWidget {
//   bool _bloquear= false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("lista inserte nombre"),
//       ),

//       body: _lista() ,

//       floatingActionButton: FloatingActionButton(
       
//         onPressed:(){
//           Navigator.pushNamed(context,"crearobjeto");
//         } ,

//         child: Icon(Icons.add),
//       ),

      
//     );
    
//   }
//    Widget _lista() {

//     // print (menuProvider.opciones);
    
    
//       return FutureBuilder(
//         future:itemProvider.cargardata() ,
//         builder: (context,AsyncSnapshot<List<dynamic>> snapshot ){

//           return ListView(
//               children: _listaItems(snapshot.data, context),
//           );

//         },
//         initialData: [],
//       );
//     }
       
//     List<Widget>_listaItems(List<dynamic>data, BuildContext context) {
//       final List<Widget> items=[];
//       data.forEach((opt){

//         final widgetTemp = CheckboxListTile(
//           title: Text(opt['articulo']),
//           value: _bloquear,
//           onChanged: (valor){
//              setState(() {
//               _bloquear=valor;
//              });  
//           }, 
//           // leading: Icon(Icons.shop),
//           // trailing: Icon(Icons.arrow_right),
//           // onTap: (){
//           //   Navigator.pushNamed(context, opt['ruta']);
//           //   final route = MaterialPageRoute(
//           //     builder: (context)=> AlertPage() 
//           //   );
//           //   Navigator.push(context, route);
//           //  },
//         );
//         items..add(widgetTemp)
//                 ..add(Divider());


        
//       });
//       return items;
//     }
// }