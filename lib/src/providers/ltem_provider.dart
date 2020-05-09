import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class _itemProvider{
  List<dynamic>item=[];
  _itemPorvider(){}
  Future<List<dynamic>>cargardata() async{
    final resp=await rootBundle.loadString("data/1.json");
    Map dataMap=json.decode(resp);
    item= dataMap["items"];
    return item;
  }
}
final itemProvider = new _itemProvider();