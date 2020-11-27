import 'package:flutter/material.dart';
import 'package:navegacion/model/Contador.dart';
import 'package:navegacion/model/ListaNombres.dart';
import 'package:navegacion/navigationDrawer/navigationDrawer.dart';
import 'package:provider/provider.dart';

class contactPage extends StatelessWidget {
 static const String routeName = '/contactPage';

 @override
 Widget build(BuildContext context) {
   final contadorInfo = Provider.of<Contador>(context);
   final listNombres = Provider.of<ListaNombres>(context);
   return new Scaffold(
       appBar: AppBar(
         title: Text("Contacts"),
         actions: [Container(
           alignment: Alignment.center,
           height: 50,
           width: 60,
           child:Text(listNombres.nombresFavoritos.length.toString(),style:TextStyle(fontSize: 20),textAlign: TextAlign.center,),
           decoration: BoxDecoration(color:Colors.blue[700],border:Border.all(color:Colors.blue[700]),borderRadius:BorderRadius.circular(100)),
         ),
         ]),
       drawer: navigationDrawer(),
       body: Center(child: Text(contadorInfo.contador.toString(),style:TextStyle(fontSize: 50,color: Colors.purple),)));
 }
}