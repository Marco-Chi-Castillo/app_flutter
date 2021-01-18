class RegistroModel {
  int _id;
  String _nombre;
  String _apellido;
  String _email;
  String _password;

  RegistroModel(
    this._id,
    this._nombre,
    this._apellido,
    this._email,
    this._password,
  );

  RegistroModel.map(dynamic obj) {
    this._id = obj['id'];
    this._nombre = obj['nombre'];
    this._apellido = obj['apellido'];
    this._email = obj['email'];
    this._password = obj['password'];
  }
  int get id => _id;
  String get nombre => _nombre;
  String get apellido => _apellido;
  String get email => _email;
  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["nombre"] = _nombre;
    map["apellido"] = _apellido;
    map["email"] = _email;
    map["password"] = _password;
    return map;
  }
}
