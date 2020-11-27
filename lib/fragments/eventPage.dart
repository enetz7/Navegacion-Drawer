import 'package:flutter/material.dart';
import 'package:navegacion/model/ListaNombres.dart';
import 'package:navegacion/navigationDrawer/navigationDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';
import 'package:navegacion/model/user.dart';
import 'package:navegacion/services/response/user_response.dart';


class eventPage extends StatefulWidget {
  eventPage({Key key}) : super(key: key);

  @override
  EventPageStage createState() => EventPageStage();
}


class EventPageStage extends State<eventPage> implements CreateUserCallBack,GetUserCallBack,DeleteUserCallBack {
 static const String routeName = '/eventPage';
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _nombre;
  CreateUserResponse _responseCreate;
  GetUserResponse _responseGet;
  DeleteUserResponse _responseDelete;
  List<User> listUser;
  EventPageState() {
    _responseCreate = new CreateUserResponse(this);
    _responseGet = new GetUserResponse(this);
    _responseDelete = new DeleteUserResponse(this);
    listUser = new List<User>(); 
    _responseGet.doGet();
  }
  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _responseCreate.doCreate(_nombre);
      });
    }
  }
  void _delete(int id) {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        _responseDelete.doDelete(id);
      });
    }
  }
  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
    SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Id')),
          DataColumn(label: Text('Username')),
          DataColumn(label: Text('Password')),
          DataColumn(label: Text('Action')),
        ],
        rows:
            listUser // Loops through dataColumnText, each iteration assigning the value to element
                .map(
                  ((element) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(element.id.toString())), //Extracting from Map element the value
                          DataCell(Text(element.nombre)),
                          DataCell( new IconButton(
                            icon: const Icon(Icons.delete_forever,
                                color: const Color(0xFF167F67)),
                            onPressed: () => _delete(element.id),
                            alignment: Alignment.centerLeft,
                          )),
                        ],
                      )),
                )
                .toList(),
      ),
    );
  }




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

  @override
  void onCreateUserError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }
  @override
  void onCreateUserSuccess(int user) async {    
    if(user > 0){
      // TODO: implement onLoginSuccess
      _responseGet.doGet();
      _showSnackBar("data has been saved successfully");
      setState(() {
        _isLoading = false;
      });
    }else{
      // TODO: implement onLoginSuccess
      _showSnackBar("Failed, please check data");
      setState(() {
        _isLoading = false;
      });
    }
    
  }
 @override
  void onGetUserError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }
   @override
  void onGetUserSuccess(List<User> user) async {    
    if(user != null){
      // TODO: implement onLoginSuccess
      listUser = user;
      setState(() {});
    }else{
    }
    
  }
  @override
  void onDeleteUserError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }
  @override
  void onDeleteUserSuccess(int user) async {    
    if(user > 0){
      _responseGet.doGet();
      // TODO: implement onLoginSuccess
      _showSnackBar("data has been delete successfully");
      setState(() {
        _isLoading = false;
      });
    }else{
      // TODO: implement onLoginSuccess
      _showSnackBar("Failed, please check data");
      setState(() {
        _isLoading = false;
      });
    }
    
  }
}