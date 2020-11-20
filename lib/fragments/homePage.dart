import 'package:flutter/material.dart';
import 'package:navegacion/model/Contador.dart';
import 'package:navegacion/navigationDrawer/navigationDrawer.dart';
import 'package:provider/provider.dart';

class homePage extends StatelessWidget {
 static const String routeName = '/homePage';


 @override
 Widget build(BuildContext context) {
    final contadorInfo = Provider.of<Contador>(context);

   return new Scaffold(
       appBar: AppBar(
         title: Text("Home"),
       ),
       drawer: navigationDrawer(),
              body: 
              Center(
                child: Text(contadorInfo.contador.toString(),style:TextStyle(fontSize: 50,color: Colors.purple),)
              ),
              floatingActionButton: FloatingActionButton(onPressed: ()=>contadorInfo.sumarContador(),backgroundColor: Colors.red,child: Icon(Icons.add),),
              );
 }
}