import 'package:flutter/material.dart';
import 'package:navegacion/model/ListaNombres.dart';
import 'package:navegacion/navigationDrawer/navigationDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

class eventPage extends StatefulWidget {
  eventPage({Key key}) : super(key: key);

  @override
  EventPageStage createState() => EventPageStage();
}


class EventPageStage extends State<eventPage>{
 static const String routeName = '/eventPage';

  List lista=[];

  @override
  void initState() {
    super.initState();
    changeList();
  }

  void changeList() async{
      lista= await loadData();
      setState(() {    
      });
  }

  Future<List<dynamic>> loadData() async {
    final response =
        await http.get('https://randomuser.me/api/?results=20');
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['results'];
    }
    return null;
  }
    

 @override
 Widget build(BuildContext context) {
   final listNombres = Provider.of<ListaNombres>(context);
   if(listNombres.listaNombres.length==0){
    listNombres.listaNombres=lista;
    listNombres.setFavorites(lista.length);
   }
   if(listNombres.listaNombres==null){ 
    return new Scaffold(
        appBar: AppBar(
          title: Text("Events"),
        actions: [Container(
           alignment: Alignment.center,
           height: 50,
           width: 60,
           child:Text(listNombres.nombresFavoritos.length.toString(),style:TextStyle(fontSize: 20),textAlign: TextAlign.center,),
           decoration: BoxDecoration(color:Colors.blue[700],border:Border.all(color:Colors.blue[700]),borderRadius:BorderRadius.circular(100)),
         ),
         ]),
        drawer: navigationDrawer(),
        body: Center(child: Text("Hey! this is events list page")));
    }else{ 
      return new Scaffold(
        appBar: AppBar(
          title: Text("Events"),
        actions: [Container(
           alignment: Alignment.center,
           height: 50,
           width: 60,
           child:Text(listNombres.nombresFavoritos.length.toString(),style:TextStyle(fontSize: 20),textAlign: TextAlign.center,),
           decoration: BoxDecoration(color:Colors.blue[700],border:Border.all(color:Colors.blue[700]),borderRadius:BorderRadius.circular(100)),
         ),
         ]),
        drawer: navigationDrawer(),
        body: SingleChildScrollView(child:Center(child: 
        Column(children: [
          for(int i=0;i<listNombres.listaNombres.length;i++)...{
            ListTile(
              leading: FlutterLogo(),
              title: Text(listNombres.listaNombres[i]['name']['first'],textAlign: TextAlign.center,),
              trailing: Icon(Icons.star,color: listNombres.favorite[i],),onTap:()=> {listNombres.changeColor(Colors.yellow[600], i), listNombres.addNombresFavoritos(listNombres.listaNombres[i]['name']['first'])},
            )
          }
        ],))));
    }
 }
}