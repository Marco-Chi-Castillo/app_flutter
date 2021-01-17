import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/models/registro_model.dart';
import 'package:reservaciones_app/src/pages/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: <Widget>[_crearFondo(context), _loginForm(context)],
        ));
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      SafeArea(
        child: Container(
          height: 180.0,
        ),
      ),
      Container(
        width: size.width * 0.85,
        margin: EdgeInsets.symmetric(vertical: 30.0),
        padding: EdgeInsets.symmetric(vertical: 50.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0)
            ]),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Text("INGRESAR", style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 60.0),
              _crearEmail(),
              SizedBox(height: 30.0),
              _crearPassword(),
              SizedBox(height: 30.0),
              _crearBoton(context)
            ],
          ),
        ),
      ),
      FlatButton(
        child: Text('Crear una nueva cuenta'),
        onPressed: () => Navigator.pushReplacementNamed(context, 'registro'),
      ),
      SizedBox(height: 100.0)
    ]));
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
          hintText: "example.e@valladolid.tecnm.mx",
          labelText: "Correo electronico",
        ),
        onSaved: (value) => _email = value,
        validator: (value) {
          if (value.length < 1) {
            return "Ingrese su nombre";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
          labelText: "Contraseña",
        ),
        onSaved: (value) => _password = value,
        validator: (value) {
          if (value.length < 1) {
            return "Ingrese su contraseña";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text(
            "Ingresar",
          )),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Colors.deepPurple[900],
      textColor: Colors.white,
      onPressed: _submit,
    );
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_email, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar("Login not successful");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(RegistroModel user) async {
    // TODO: implement onLoginSuccess
    if (user.email == "") {
      _showSnackBar("Login not successful");
    } else {
      _showSnackBar(user.toString());
    }
    setState(() {
      _isLoading = false;
    });
    if (user.flaglogged == "logged") {
      // print("Logged");
      Navigator.of(context).pushNamed("home");
    } else {
      return null;
      //print("Not Logged");
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(35, 60, 154, 1.0),
        Color.fromRGBO(27, 54, 154, 1.0)
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, right: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text("ITSVA",
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}
