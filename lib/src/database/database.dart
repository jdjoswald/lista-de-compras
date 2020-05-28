import "package:sqflite/sqflite.dart";
import "dart:async";

// class Lista{
//   int id;
//   String name;
//   Lista(this.name);

//   Map<String, dynamic> toMap(){
//     return{
//       "name":name,
//     };
//   }

//   Lista.fromMap(Map<String, dynamic > map) {
//     id: map["id"];
//     name: map["name"];
//   }


// }

class Shoplistdb{
  Database _db;

  InitDB() async{
   _db = await openDatabase('sl8.db',
    version: 1,
    onCreate: (Database db, int version){
      print("klkmenol");
      db.execute("CREATE TABLE shoplists(id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT NOT NULL)");
      db.execute("CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT,idl INT, name TEXT NOT NULL,precio INT,link TEXT,divisa TEXT, estado INT)");
      db.execute("CREATE TABLE dolar(id INTEGER PRIMARY KEY AUTOINCREMENT, precio INT )");
    },
   );
   
  }
  insert(Map lista)async{
    InitDB();
    _db.insert("shoplists", lista);
  }
  insert2(Map lista)async{
    InitDB();
    _db.insert("items", lista);
  }

 deleteitem( int item)async{
    InitDB();
    _db.rawQuery("DELETE FROM items WHERE id=$item");
  }
  deletelist(int lista)async{
    InitDB();
    _db.rawQuery("DELETE FROM items WHERE idl=$lista");
    _db.rawQuery("DELETE FROM shoplists WHERE id=$lista");
  }
  
  sum( int item)async{
    InitDB();
    _db.rawQuery("select sum(precio) FROM items WHERE id=$item");
  }

  updateitems( int id, String nombre, String divisa, String url, String costo)async{
    InitDB();
    _db.rawQuery("UPDATE items SET dolar WHERE id=$id");
  }
  updatelist( int list)async{
    InitDB();
    _db.rawQuery("UPDATE shoplists SET dolar WHERE id=1");
  }

  

  Future<List<dynamic>> getAllLists( )async{
    InitDB();
    List<dynamic>item=[];
   List<Map<String, dynamic>> results = await _db.rawQuery("SELECT * FROM shoplists");
    item= results;
    return item;
  }
  Future<List<dynamic>> getitems(int id )async{
    InitDB();
    List<dynamic>item=[];
   List<Map<String, dynamic>> results = await _db.rawQuery("SELECT * FROM items WHERE idl=$id");
    item= results;
    return item;
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