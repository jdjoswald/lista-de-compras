import "package:sqflite/sqflite.dart";
import "dart:async";

class Shoplistdb{
   var klk=Duration(seconds: 1);
  Database _db;

  InitDB() async{
   _db = await openDatabase('sl9.db',
    version: 1,
    onCreate: (Database db, int version){
      db.execute("CREATE TABLE shoplists(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT NOT NULL)");
      db.execute("CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT,idl INT, name TEXT NOT NULL,precio INT,link TEXT,divisa TEXT, estado INT)");
      db.execute("CREATE TABLE dolar(id INTEGER PRIMARY KEY AUTOINCREMENT, precio INT )");
      // db.rawQuery("INSERT INTO dolar(precio) VALUES(1)");
      db.execute("CREATE TABLE estado(id INTEGER PRIMARY KEY AUTOINCREMENT, estado TEXT )");
      db.execute("ALTER TABLE items ADD priority INT");
    },
   );
  }


  insert(Map lista)async{
    // InitDB();
    _db.insert("shoplists", lista);
  }


  insert2(Map lista)async{
    // InitDB();
    _db.insert("items", lista);
  }


 deleteitem( int item)async{
    // InitDB();
    _db.rawQuery("DELETE FROM items WHERE id=$item");
  }


  deletelist(int lista)async{
    // InitDB();
    _db.rawQuery("DELETE FROM items WHERE idl=$lista");
    _db.rawQuery("DELETE FROM shoplists WHERE id=$lista");
    // _db.rawQuery("ALTER TABLE items ADD priority INT");

  }


  comprado(int id, int estado)async{
    if(estado==0){
      _db.rawQuery("UPDATE items SET estado = 1 WHERE id=$id"); 
   }else{
      _db.rawQuery("UPDATE items SET estado = 0 WHERE id=$id"); 
   }
  }

  
  


  updateitems( int id, String nombre, String divisa, String url, int costo)async{
    // InitDB();
    if(nombre!=""){
      _db.rawQuery("UPDATE items SET name = '$nombre' WHERE id=$id");
      print("editado a $nombre");}
    if(url!=""){
      _db.rawQuery("UPDATE items SET link = '$url' WHERE id=$id");
      print("editado a $url");}
    if(costo!=0){
      _db.rawQuery("UPDATE items SET precio = '$costo' WHERE id=$id");
      print("editado a $costo");}
    if(divisa!=""){
      _db.rawQuery("UPDATE items SET divisa = '$divisa' WHERE id=$id");
      print("editado a $divisa");}
  }


  updatelist( int id ,String name)async{
    _db.rawQuery("UPDATE shoplists SET name= '$name'  WHERE id=$id");
  }


  updatedolar( int precio)async{
      _db.rawQuery("UPDATE dolar SET precio = '$precio' WHERE id=1");
  }
  

  Future<List<dynamic>> getAllLists( )async{
    List<dynamic>item=[];
    List<Map<String, dynamic>> results = await Future.delayed( klk,()=>_db.rawQuery("SELECT * FROM shoplists")) ;
    //  List<Map<String, dynamic>> results = await _db.query("shoplists");
    
    return results;
  }


  Future<List<dynamic>> getitems(int id )async{
    
    List<dynamic>item=[];
    if (id==9000){
      List<Map<String, dynamic>> results = await Future.delayed( klk,()=> _db.rawQuery("SELECT * FROM items ORDER by precio"));
      
      item= results;
    }else{
      List<Map<String, dynamic>> results = await  Future.delayed( klk,()=> _db.rawQuery("SELECT * FROM items WHERE idl=$id"));
      item= results;
      // print(item);
    }
    return item;
  }
  Future<int> dolar()async{
    int dolarr;
    List<dynamic>dolar=[];
   List<Map<String, dynamic>> results = await Future.delayed( klk,()=>_db.rawQuery("SELECT * FROM dolar WHERE id=1"));
    dolar= results;
    dolar.forEach((element) {dolarr= element["precio"];});
    // print( "klk $dolarr");


    return dolarr;
  }

   Future<int> suma(int id ,int dolar)async{
    //  print (" suma $dolar");
    int suma=0;
    List<dynamic>sumas=[];
    if(id==9000){
       List<Map<String, dynamic>> results = await  Future.delayed( klk,()=>_db.rawQuery("SELECT SUM(precio) FROM items WHERE estado=0  AND divisa='Peso';"));
       sumas= results;
    }
    else{
      List<Map<String, dynamic>> results = await  Future.delayed( klk,()=>_db.rawQuery("SELECT SUM(precio) FROM items WHERE idl=$id AND estado=0  AND divisa='Peso';"));
      sumas= results;
    }
    sumas.forEach((element) {
      suma= element["SUM(precio)"];
    });

    if(id==9000){
       List<Map<String, dynamic>> results = await  Future.delayed( klk,()=>_db.rawQuery("SELECT SUM(precio) FROM items WHERE estado=0  AND divisa='Dolar';"));
       sumas= results;
    }
    else{
      List<Map<String, dynamic>> results = await  Future.delayed( klk,()=>_db.rawQuery("SELECT SUM(precio) FROM items WHERE idl=$id AND estado=0  AND divisa='Dolar';"));
      sumas= results;
    } 

    sumas.forEach((element) {
      if (suma==null){suma=0;}
      if(element["SUM(precio)"]!=null){
        int k= element["SUM(precio)"];
      suma= suma +  (element["SUM(precio)"]*dolar);}
    }); 


    return suma;
  }


}
































































// class Lista{
//   String name;
//   Lista(this.name);
//   Map<String, dynamic> toMap(){
//     return{
//         "name": name,
//     };

//   }
//   Lista.fromMap(Map<String,dynamic > map){
//       name: map["name"];
//   }

// }
// class ListaDatabase {
//   Database _db;
//   initDB() async{
//     _db = await openDatabase("my_db.db",
//     version: 1, 
//     onCreate:(Database db, int vesrion){
//         db.execute("CREATE TABLE lista (id INTERGER PRIMARY KEY, name TEXT NOT NULL);");
//          print("CREADA DB ");

//      } 
//     );
    
//   }
//   insert(Lista lista) async{
//       _db.insert("lista", lista.toMap());
//   }
//   Future<List<Lista>>getAlllista()async{
    
//     List<Map<String, dynamic>> result = await _db.query("lista");
//     return result.map((map)=>Lista.fromMap(map));
//   }
// }