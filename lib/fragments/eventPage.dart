import 'package:flutter/material.dart';
import 'package:navegacion/model/Contador.dart';
import 'package:navegacion/model/ListaNombres.dart';
import 'package:navegacion/navigationDrawer/navigationDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';
class eventPage extends StatelessWidget {
 static const String routeName = '/eventPage';

  List lista=[];

  void initState() {
    lista=loadData() as List;
  }

  Future<List<dynamic>> loadData() async {
    final response =
        await http.get('https://next.json-generator.com/api/json/get/NJV2XGl8E');
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse;
    }
    return null;
  }
    

 @override
 Widget build(BuildContext context) {
   final listNombres = Provider.of<ListaNombres>(context);
   listNombres.setListaNombres(lista);
   if(listNombres.listaNombres==null){
    return new Scaffold(
        appBar: AppBar(
          title: Text("Events"),
        ),
        drawer: navigationDrawer(),
        body: Center(child: Text("Hey! this is events list page")));
    }else{
      return new Scaffold(
        appBar: AppBar(
          title: Text("Events"),
        ),
        drawer: navigationDrawer(),
        body: Center(child: 
        Column(children: [
          for(int i=0;i<listNombres.listaNombres.length;i++)...{
            ListTile(
              title: Text(listNombres.listaNombres[i]),
            )
          }
        ],)));
    }
 }
}