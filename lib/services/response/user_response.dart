import 'package:navegacion/services/request/user_request.dart';
import 'package:navegacion/model/user.dart';
abstract class CreateUserCallBack {
  void onCreateUserSuccess(int user);
  void onCreateUserError(String error);
}
abstract class GetUserCallBack {
  void onGetUserSuccess(List<User> user);
  void onGetUserError(String error);
}
abstract class DeleteUserCallBack {
  void onDeleteUserSuccess(int user);
  void onDeleteUserError(String error);
}
class CreateUserResponse {
  CreateUserCallBack _callBackCreate;
  UserRequest userRequest = new UserRequest();
  CreateUserResponse(this._callBackCreate);
  doCreate(String nombre) {
    var fido = User(nombre);
    
    userRequest
        .createUser(fido)
        .then((user) => _callBackCreate.onCreateUserSuccess(user))
        .catchError((onError) => _callBackCreate.onCreateUserError(onError.toString()));
  } 
}
class GetUserResponse {
  GetUserCallBack _callBackGet;
  UserRequest userRequest = new UserRequest();
  GetUserResponse(this._callBackGet);
  doGet() {    
    userRequest
        .getUser()
        .then((user) => _callBackGet.onGetUserSuccess(user))
        .catchError((onError) => _callBackGet.onGetUserError(onError.toString()));
  } 
}
class DeleteUserResponse {
  DeleteUserCallBack _callBackDelete;
  UserRequest userRequest = new UserRequest();
  DeleteUserResponse(this._callBackDelete);
  doDelete(int id) {
    
    userRequest
        .deleteUser(id)
        .then((user) => _callBackDelete.onDeleteUserSuccess(user))
        .catchError((onError) => _callBackDelete.onDeleteUserError(onError.toString()));
  } 
}