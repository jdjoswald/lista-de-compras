import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:listadecompras/src/providers/ltem_provider.dart';
import "package:flutter_slidable/flutter_slidable.dart";


class ListaDeArticulos extends StatefulWidget {
  @override
  _ListaDeArticulosState createState() => _ListaDeArticulosState();
}
class _ListaDeArticulosState extends State<ListaDeArticulos> {
  bool comprado= false;
  List<String> _poderes=["Dolar","Peso"];
  String _opcionSeleccionada= "Peso";
  String listName="";
  int sun =0;
  int k=0;
  int dolar=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                leading:Column(
                  children: 
                  <Widget>[
                    Padding(padding: EdgeInsets.all(5.0)),
                    Text("Total"),
                    Text(Suma()),

                  ]
                ),
                title: Text("lista $listName"),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: null),
                  IconButton(icon: Icon(Icons.attach_money, color: Colors.white,), onPressed: ()=> _precio(context),),
                  IconButton(icon: Icon(Icons.info, color: Colors.white,), onPressed: ()=> _help(context),)
                ],
        
              ),
              body: _lista() ,
              floatingActionButton: FloatingActionButton(
                onPressed: ()=> _crearitem(context,"","",0,""),
                child: Icon(Icons.add),
              ),  
            );
          }
        
        
  Widget _lista() {
    return FutureBuilder(
      future:itemProvider.cargardata() ,
      builder: (context,AsyncSnapshot<List<dynamic>> snapshot ){
        return RefreshIndicator(  
          onRefresh: refresh,
          child:ListView(
              children: _listaItems(snapshot.data, context),
        ));
      },
      initialData: [],
    );
  }


    List<Widget>_listaItems(List<dynamic>data, BuildContext context) {
      final List<Widget> items=[];
      data.forEach((opt){
      int precio=opt['precio'];
      if (k<data.length){
        if(opt["divisa"]=="Dolar" && opt["estado"]==false){
          sun= sun + (precio*dolar).toInt();

        }else if (opt["estado"]==false){
          sun = sun + precio;}
            k=k+1;}
        final widgetTemp =Slidable(
          actionPane: SlidableBehindActionPane(),
          secondaryActions: <Widget>[
            FlatButton(
              color: Colors.red,
              onPressed: Borrar, 
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
              onPressed: () => _crearitem(context, opt["name"],  opt["link"],  opt["precio"],  opt["divisa"]), 
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
          child:  CheckboxListTile( 
            title: Row (
              children: <Widget>[
                Text(opt['articulo']),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 1,
                  ),
                ),
                Text(" $precio ")
              ],
            ),
            value:opt["estado"],
            secondary: Column(
              children: <Widget>[
                IconButton(onPressed:()=> _veritem(context,opt['articulo'], opt["link"],precio, opt["divisa"]),icon: Icon(Icons.remove_red_eye)),
              ] 
            ),
            onChanged: (valor){
              setState(() {
              comprado=valor;
              });  
            }, 
        ), 
        ) ;
        
        
        items..add(widgetTemp)
              ..add(Divider());  
      });
      return items;
    }


  _crearitem(BuildContext context, String nombre,String url,int costo, String divisa) {
    print("$nombre $url ");
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          title: Text("Crear item"),
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
              _crearinput(nombre,url,costo,divisa),
            ],
          ),
          actions: <Widget>[
            FlatButton(onPressed: Nuevoitem, child: Text("OK")),
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
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: "Nombre",
            helperText: "Escribe el nombre del producto que quieres crear",
            suffixIcon: Icon(Icons.list,color: Colors.blue,),
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
            suffixIcon: Icon(Icons.place, color: Colors.blue,),
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
            suffixIcon: Icon(Icons.attach_money, color: Colors.blue,),
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


  _veritem(BuildContext context, String nombre,String url,int costo, String divisa) {
    if(divisa=="Dolar"){divisa="Dolares";}
    else{divisa="Pesos";}
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
              Text(" Este articulo cuesta $costo $divisa"),              
            ] 
          ),
          actions: <Widget>[
            FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("OK")),
            FlatButton(onPressed: (){Clipboard.setData(ClipboardData(text: url));}, child: Text("copiar url")),
            FlatButton(onPressed: null, child: Text("ir a tienda")),
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
            FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("OK")),
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
              // onChanged: (valor){
              //   setState(() {
              //     _nombre=valor;
              //   });               
              // },           
   );
  }
        
  Nuevoitem(){
    k=0;
    sun=0;
    return Navigator.of(context).pop();
  }
        
  String Suma() {
    return sun.toString();
  }
  

  void Borrar() {
    print ("holi");

  }
  Future<Null> refresh()async{
       setState(() {
        }); 
        return null;   

    }
}