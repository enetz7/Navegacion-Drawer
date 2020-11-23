import 'package:flutter/material.dart';

class ListaNombres with ChangeNotifier{
  
  int contador =0;

  List listaNombres =[];

  void sumarContador(){
    this.contador++;

    notifyListeners();
  }

  get getListaNombres{
    return listaNombres;
  }

  void setListaNombres(List lista){
    this.listaNombres=lista;

    notifyListeners();
  }
}