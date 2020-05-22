
































































// import "package:sqflite/sqflite.dart";
// import "dart:async";
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