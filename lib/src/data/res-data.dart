import 'dart:async';
import 'package:reservaciones_app/src/models/registro_model.dart';
import 'package:reservaciones_app/src/providers/db_provider.dart';

class RestData {
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  Future<RegistroModel> login(String email, String password) async {
    String flagLogged = "logged";
    //simulate internet connection by selecting the local database to check if user has already been registered
    var user = new RegistroModel(null, null, email, password, null);
    var db = new DBProvider();
    var userRetorno = new RegistroModel(null, null, null, null, null);
    userRetorno = await db.selectUser(user);
    print (userRetorno);
    if (userRetorno != null) {
      flagLogged = "logged";
      return new Future.value(
          new RegistroModel(null, null, email, password, flagLogged));
    } else {
      flagLogged = "not";
      return new Future.value(
          new RegistroModel(null, null, email, password, flagLogged));
    }
  }
}
