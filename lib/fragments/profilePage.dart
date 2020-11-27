import 'package:flutter/material.dart';
import 'package:navegacion/model/ListaNombres.dart';
import 'package:navegacion/navigationDrawer/navigationDrawer.dart';
import 'package:provider/provider.dart';

class profilePage extends StatelessWidget {
 static const String routeName = '/profilePage';

 @override
 Widget build(BuildContext context) {
   final listNombres = Provider.of<ListaNombres>(context);
   return new Scaffold(
       appBar: AppBar(
         title: Text("My Profile"),
       actions: [Container(
           alignment: Alignment.center,
           height: 50,
           width: 60,
           child:Text(listNombres.nombresFavoritos.length.toString(),style:TextStyle(fontSize: 20),textAlign: TextAlign.center,),
           decoration: BoxDecoration(color:Colors.blue[700],border:Border.all(color:Colors.blue[700]),borderRadius:BorderRadius.circular(100)),
         ),
         ]),
       drawer: navigationDrawer(),
       body: Center(child: Text("This is profile page")));
 }
}