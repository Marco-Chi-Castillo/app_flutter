import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/models/registro_model.dart';
import 'package:reservaciones_app/src/providers/db_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String _email, _password;

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
        controller: emailController,
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
        controller: passwordController,
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

  _submit() async {
    if (formKey.currentState.validate()) {
      DBProvider db = new DBProvider();
      var user = new RegistroModel(
          null, null, null, emailController.text, passwordController.text);
      db.getUser(user).then((List<RegistroModel> users) {
        if (users != null && users.length > 0) {
          Navigator.pushNamed(context, 'home');

          // print("[Login Page] submit : Succes");
        } else {
          mostrarSnackbar('DATOS INCORRECTOS O USUARIO NO EXISTENTE');
          // print("[Login Page] submit : Credenciales invalidas");
        }
      });
    }
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
        content: Text(mensaje),
        duration: Duration(
          milliseconds: 5000,
        ));

    scaffoldKey.currentState.showSnackBar(snackbar);
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
