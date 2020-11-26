import 'package:flutter/material.dart';
import 'package:navegacion/model/ListaNombres.dart';
import 'package:navegacion/navigationDrawer/navigationDrawer.dart';
import 'package:provider/provider.dart';

class notificationPage extends StatelessWidget {
 static const String routeName = '/notificationPage';

 @override
 Widget build(BuildContext context) {
   final listNombres = Provider.of<ListaNombres>(context);
   if(listNombres.nombresFavoritos==null){ 
   return new Scaffold(
       appBar: AppBar(
         title: Text("Notifications"),
       ),
       drawer: navigationDrawer(),
       body: Center(child: Text("This is notification page")));
   }else{
     return new Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        drawer: navigationDrawer(),
        body: SingleChildScrollView(child:Center(child: 
        Column(children: [
          for(int i=0;i<listNombres.nombresFavoritos.length;i++)...{
            ListTile(
              leading: FlutterLogo(),
              title: Text(listNombres.nombresFavoritos[i],textAlign: TextAlign.center,),
              trailing: Icon(Icons.star,color: Colors.yellow[600],)
            )
          }
        ],))));
   }
 }
}