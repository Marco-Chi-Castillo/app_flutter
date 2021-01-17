import 'package:reservaciones_app/src/data/res-data.dart';
import 'package:reservaciones_app/src/models/registro_model.dart';

abstract class LoginPageContract {
  void onLoginSuccess(RegistroModel user);
  void onLoginError(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;
  RestData api = new RestData();
  LoginPagePresenter(this._view);

//Simulator login
  doLogin(String email, String password) {
    api
        .login(email, password)
        .then((user) => _view.onLoginSuccess(user))
        .catchError((onError) => _view.onLoginError(onError));
  }
}
