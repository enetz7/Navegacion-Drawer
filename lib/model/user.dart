class User {
  int _id;
  String _nombre;
  User(this._nombre);
  User.fromMap(dynamic obj) {
    this._id = obj['id'];
    this._nombre = obj['nombre'];
  }
  String get nombre => _nombre;
  int get id => _id;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["nombre"] = _nombre;
    return map;
  }
}