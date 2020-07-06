import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listadecompras/src/database/database.dart';
import 'package:listadecompras/src/providers/ltem_provider.dart';
import "package:flutter_slidable/flutter_slidable.dart";
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';



class ListaDeArticulos extends StatefulWidget {
  final int idl;
  final String nombrel;
  ListaDeArticulos({Key key, this.idl, this.nombrel}): super (key: key);
  @override
  _ListaDeArticulosState createState() => _ListaDeArticulosState();
}
class _ListaDeArticulosState extends State<ListaDeArticulos> {
  Shoplistdb db = Shoplistdb();
  bool comprado= false;
  List<String> _poderes=["Dolar","Peso"];
  String _opcionSeleccionada= "Peso";
  int k=0;
  int paso=0;
  String nombrer="";
  String urlr="";
  String costor="";
  Future<int> sumas;
  int dolari;
  int dolar=1;
  @override
  Widget build(BuildContext context) {
    db.InitDB();
    getdolar(context);
        return Scaffold(
                appBar: AppBar(
                  leading:Column(
                    children: 
                    <Widget>[
                      Padding(padding: EdgeInsets.all(5.0)),
                      Text("Total"),
                      getsuma(context),
                    ]
                  ),
                  title: Text("lista ${ widget.nombrel}"),
                  actions: <Widget>[
                    IconButton(icon: Icon(Icons.refresh, color: Colors.white,), onPressed:()=> refresh()),
                    IconButton(icon: Icon(Icons.attach_money, color: Colors.white,), onPressed: ()=> _precio(context),),
                    IconButton(icon: Icon(Icons.info, color: Colors.white,), onPressed: ()=> _help(context),)
                  ],
                ),
                body: _listaItems(context),  
                floatingActionButton: FloatingActionButton(
                  onPressed: ()=> _crearitem(context,"","",0,""),
                  child: Icon(Icons.add),
                ),  
        );
      }
        
         
      _listaItems( BuildContext context) {
        return FutureBuilder(
          future: db.getitems(widget.idl),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot){      
            if (snapshot.hasData ==   true){     
               if(snapshot.data.length==0){ 
                 
                  return Center(
                    child:Text("añade un item"),
                  );
               } 
              else {
                return(RefreshIndicator(  
                onRefresh: refresh,
                child:ListView(
                    children:_listas(snapshot.data, context)
                )
                ));
              }
            }else{
             return Center(
               child: CircularProgressIndicator(),
             );
            }  
          }
        );
      }
        
        
      List<Widget> _listas (List<Map> data, BuildContext context)  {
        final List<Widget> items=[];
        data.forEach((opt) { 
          int preciop;
          if(opt['divisa']=="Dolar"){
            preciop=(opt['precio'])*dolar;
          }
          else{
            preciop=opt["precio"];
          }
          final widgetTemp =Slidable(
            actionPane: SlidableBehindActionPane(),
            actions: <Widget>[
              FlatButton(
                color: Colors.blue,
                onPressed: ()=>_veritem(context,opt["id"], opt['name'], opt['link'], opt['precio'].toString(), opt['divisa'] ,opt["estado"]),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4.0)),
                    Icon(Icons.remove_red_eye),
                    Text("Detalles")
                  ],
                )
              ),
              FlatButton(
                color: Colors.yellow,
                onPressed: ()=>_launchURL(opt["link"]),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4.0)),
                    Icon(Icons.shopping_basket),
                    Text("ir a tienda")
                  ],
                )
              ),
            ],
            secondaryActions: <Widget>[
              FlatButton(
                color: Colors.red,
                onPressed: ()=>Borrar(opt["id"]), 
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4.0)),
                    Icon(Icons.delete),
                    Text("Borrar")
                  ],
                )
              ),
              FlatButton(
                color: Colors.green,
                onPressed: () => edit(context, opt["id"], opt["name"], opt["link"], opt["precio"], opt["divisa"]),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4.0)),
                    Icon(Icons.edit),
                    Text("Editar")
                  ],
                )
              )
            ],
            child :CheckboxListTile(
              value: inttobool(opt["estado"]),
              onChanged: (valor){
                setState(() {                
                db.comprado(opt["id"], opt["estado"]);
                paso=0;
                });  
              },           
              title: Row (
                children: <Widget>[
                  Text(opt['name']),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 1,
                    ),
                  ),
                  Text(preciop.toString())
                ],
              ), 
            )
          );
          items..add(widgetTemp)
                ..add(Divider());
        });   
        return items;
      }
             
        
          _crearitem(BuildContext context, String nombre,String url,int costo, String divisa) {
            if (divisa!=""){_opcionSeleccionada=divisa;}
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context){
                return AlertDialog(
                  title: Text("Crear item"),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width:2000000.0,
                          height:2.0,
                          decoration: BoxDecoration(
                            color: Colors.white
                          ),
                        ),
                        _crearinput(nombre,url,costo,divisa),
                      ],
                  ),
                  actions: <Widget>[
                    FlatButton(onPressed: ()=> Nuevoitem(), child: Text("OK")),
                    FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Cancelar")),
                  ],
                );
              }
            );
          }
        
          Widget _crearinput( String nombre,String url,int costo, String divisa) {
            if (divisa==_poderes[0]){
              _opcionSeleccionada=_poderes[0];
            }
             final cname = TextEditingController()..text=nombre;
             final cprecio = TextEditingController()..text=costo.toString();
             final curl = TextEditingController()..text=url;
            //  cname.text=nombre;
            return  Column(
                children: <Widget>[
                  TextField(
                    controller: cname,
                    decoration: InputDecoration(
                      labelText: "Nombre",
                      helperText: "Escribe el nombre del producto que quieres crear",
                      suffixIcon: Icon(Icons.list,color: Colors.blue,),
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      )
                    ),
                    onChanged: (valor){
                      setState(() {
                        nombrer=valor;
                  });               
                }, 
                  ),
                  Divider(),
                  TextField(
                    controller: curl,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      labelText: "url",
                      helperText: "Escribe el Link del lugar donde compraras el Articulo",
                      suffixIcon: Icon(Icons.place, color: Colors.blue,),
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      )
                    ),
                    onChanged: (valor2){
                      setState(() {
                        urlr=valor2;
                  });               
                }, 
                  ),
                  Divider(),
                  TextField(
                    controller: cprecio,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Costo",
                      helperText: "cuanto cuesta el articulo",
                      suffixIcon: Icon(Icons.attach_money, color: Colors.blue,),
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      )
                    ),
                    onChanged: (valor3){
                      setState(() {
                        costor=valor3;
                      });               
                    }, 
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
                      suffixIcon: Icon(Icons.attach_money,color: Colors.blue,),
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
        
           Nuevoitem(){
            if(nombrer!="" && costor!="" && urlr!="" ){
              int rcost= int.parse(costor);
              Map <String , dynamic  >nuevo= {"idl": widget.idl,           
                                             "name": nombrer,
                                             "precio":rcost,
                                              "link": urlr,
                                              "divisa":_opcionSeleccionada,
                                              "estado": 0
                                              };
              db.insert2(nuevo);
              nombrer="";
              costor="";
              urlr="";
              k=0;
            // sun=0;
              Navigator.of(context).pop();
              setState(() {
              });
            }
          }
        
        
        
        
          _veritem( BuildContext context,int id, String nombre,String url,String costo, String divisa ,int estado) {
            String estador;
            if(divisa=="Dolar"){divisa="Dolares";}
            else{divisa="Pesos";}
            if (estado==0){
              estador="aun no se compra";
            }else{
              estador= "comprado";}
            showDialog(
              context: context,
                barrierDismissible: true,
              builder: (context){
                return AlertDialog(
                    title: Text(nombre),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    content:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Divider(),  
                      Text(" Este articulo cuesta $costo $divisa , $estador"),              
                    ] 
                  ),
                  actions: <Widget>[
                    FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("OK")),
                    FlatButton(onPressed: ()=>copyurl(url), child: Text("copiar url")),
                    FlatButton(onPressed: ()=> _launchURL(url), child: Text("ir a tienda")),
                  ],
                );
              }
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
                      Text("En esta pantalla puede ver una lista de todos los articulos en la lista  de compras un swippe a la izquierda abre una lista de botones en donde podra elimnarla o editar "),
                      Divider(),
                      Text("En el boton + puede añadir otro articulo") 
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
                    FlatButton(onPressed: ()=>cambio(), child: Text("OK")),
                  ],
                );
              }
            );
          }
        
             Widget _crearinput2() {
            return TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "precio actual del dolar",
                helperText: "ingrese el precio actual del dolar",
                icon: Icon(Icons.attach_money, color: Colors.blue,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
              ),
              onChanged: (valor){
                setState(() {
                   dolari= int.parse(valor);
                });               
              },           
            );
          }
        
          cambio(){
            db.updatedolar(dolari);
            Navigator.of(context).pop();
        
          }
        
        
          void Borrar(int id) {
            // print ("$id");
            db.deleteitem(id);
            refresh();
        
          }
        
        
          Future<Null> refresh()async{
               setState(() {
                
                }); 
                return null;   
            }
        
        
          _launchURL(String url) async {
          
            if (await canLaunch(url)) {
              await launch(url);
            } else {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Alerta"),
                      content:Text("no se puedo abrir la pagina $url agregaa pagina en formato: www.paginadeejemplo.com"),
                      actions: <Widget>[
                         FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("OK")),
                      ],
                      
                    );
                  }
              );
            }
              
              
              
              
              
            
          }
        
        
        
          edit(BuildContext context, int id,String nombre,String url,int costo, String divisa) {
            print("$nombre $url ");
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context){
                return AlertDialog(
                  title: Text("Editar item $nombre"),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width:2000000.0,
                          height:2.0,
                          decoration: BoxDecoration(
                            color: Colors.white
                          ),
                        ),
                        _crearinput(nombre,url,costo,divisa),
                      ],
                  ),
                  actions: <Widget>[
                    FlatButton(onPressed: ()=> edittodb(id,nombre,costo,url), child: Text("editar")),
                    FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("Cancelar")),
                  ],
                );
              }
            );
          }
        
        
      edittodb(int id ,String nombre, int costo ,String url){
        int rcost;
        if( costor!=""  ){
          rcost= int.parse(costor);}
        else{
          rcost=costo;
        }
          db.updateitems(id, nombrer, _opcionSeleccionada, urlr, rcost);
        nombrer="";
        costor="";
        urlr="";
        k=0;
        Navigator.of(context).pop();
        setState(() {
        });
      }
        
        
          editstatus(int id, int estado){
            db.comprado(id, estado);
            Navigator.of(context).pop();
          }
        
    
           bool inttobool(opt) {
             if(opt==0){
               return false;
             }
             else{
               return true;
             }
          }
    
    
          copyurl(url) {
            Clipboard.setData(ClipboardData(text: url));
            Fluttertoast.showToast(
                msg: "url copiada",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        
      getsuma( BuildContext context) {

        return FutureBuilder(
          future: db.suma(widget.idl, dolar),
          builder: (context, AsyncSnapshot<int> snapshot){      
            if (snapshot.hasData ==   true){  
              var sun=snapshot.data;    
              return(Text("$sun"));
            }
            else{
             return (Text("0"));
            }  
          }
        );
      }
    
  getdolar(BuildContext context) async{
    dolar=await db.dolar();
  }


    
  



      
    

  // String sumitem(BuildContext context, List data) {
  //   String items;
  //   data.forEach((opt) { 
  //      items=opt["sum(precio)"].toString();
  //   });
  //   print (items);
  //    return items; 
  // }

  
}



