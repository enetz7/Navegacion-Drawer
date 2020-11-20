import 'package:flutter/material.dart';

class Contador with ChangeNotifier{
  
  int contador =0;

  void sumarContador(){
    this.contador++;

    notifyListeners();
  }
}