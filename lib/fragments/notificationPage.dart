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
       actions: [Container(
           alignment: Alignment.center,
           height: 50,
           width: 60,
           child:Text(listNombres.nombresFavoritos.length.toString(),style:TextStyle(fontSize: 20),textAlign: TextAlign.center,),
           decoration: BoxDecoration(color:Colors.blue[700],border:Border.all(color:Colors.blue[700]),borderRadius:BorderRadius.circular(100)),
         ),
         ]),
       drawer: navigationDrawer(),
       body: Center(child: Text("This is notification page")));
   }else{
     return new Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
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