import 'package:navegacion/model/user.dart';
import 'dart:async';
import 'package:navegacion/data/database_helper.dart';

class UserCtr {
  DatabaseHelper con = new DatabaseHelper();
//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    print("Usuario query");
    int res = await dbClient.insert("User", user.toMap());
    //int res = await dbClient.rawInsert(
    //    "INSERT INTO USER (id,nombre) VALUES('$user.id','$user.nombre')");
    return res;
  }

  //deletion
  Future<int> deleteUser(int user) async {
    var dbClient = await con.db;
    int res = await dbClient.rawDelete('DELETE FROM User WHERE id = ?', [user]);
    return res;
  }

  Future<User> checkUser(String user) async {
    var dbClient = await con.db;
    var res =
        await dbClient.rawQuery("SELECT * FROM user WHERE nombre = '$user'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }
    return null;
  }

  Future<List<User>> getAllUser() async {
    var dbClient = await con.db;
    var res = await dbClient.query("user");

    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;
    return list;
  }
}
