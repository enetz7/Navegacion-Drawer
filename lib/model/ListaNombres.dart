import 'package:flutter/material.dart';

class ListaNombres with ChangeNotifier{
  
  int contador =0;

  List listaNombres =[];

  List favorite =[];

  List nombresFavoritos =[];

  void sumarContador(){
    this.contador++;

    notifyListeners();
  }

  void setFavorites(int long){
    for(int i=0;i<long;i++){
      favorite.add(Colors.grey[850]);
    }
  }

  get getListaNombres{
    return listaNombres;
  }

  void setListaNombres(List lista){
    this.listaNombres=lista;

    notifyListeners();
  }

  void changeColor(Color color,int indice){
    if(favorite[indice]==Colors.yellow[600]){
      favorite[indice]=Colors.grey[850];
    }else{
      favorite[indice]=color;
    }

    notifyListeners();
  }

  void addNombresFavoritos(String nombre){

    if(!nombresFavoritos.contains(nombre)){
      nombresFavoritos.add(nombre);
      notifyListeners();
    }else{
      nombresFavoritos.remove(nombre);
    }
  }

}