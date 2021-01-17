class RegistroModel {
  String _nombre;
  String _apellido;
  String _email;
  String _password;
  String _flaglogged;

  RegistroModel(this._nombre, this._apellido, this._email, this._password,
      this._flaglogged);

  RegistroModel.map(dynamic obj) {
    this._nombre = obj['nombre'];
    this._apellido = obj['apellido'];
    this._email = obj['email'];
    this._password = obj['password'];
    this._flaglogged = obj['password'];
  }

  String get nombre => _nombre;
  String get apellido => _apellido;
  String get email => _email;
  String get password => _password;
  String get flaglogged => _flaglogged;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["nombre"] = _nombre;
    map["apellido"] = _apellido;
    map["email"] = _email;
    map["password"] = _password;
    map["flaglogged"] = _flaglogged;
    return map;
  }
}
