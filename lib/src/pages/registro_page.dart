import 'package:flutter/material.dart';

import 'package:reservaciones_app/src/models/registro_model.dart';
import 'package:reservaciones_app/src/providers/db_provider.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _nombre, _apellido, _email, _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final registrosListProvider = Provider.of<RegistroListProvider>(context);
    return Scaffold(
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
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.symmetric(vertical: 40.0),
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
              Text("CREAR CUENTA", style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 30.0),
              _crearNombre(),
              SizedBox(height: 30.0),
              _crearApellido(),
              SizedBox(height: 30.0),
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
        child: Text('¿Ya tienes cuenta? Login'),
        onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
      ),
      SizedBox(height: 100.0)
    ]));
  }

  Widget _crearNombre() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          icon: Icon(Icons.people_alt, color: Colors.deepPurple),
          labelText: "Nombre",
        ),
        onSaved: (value) => _nombre = value,
        validator: (value) {
          if (value.length == 0) {
            return 'Ingrese el nombre ';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _crearApellido() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          icon: Icon(Icons.people_alt, color: Colors.deepPurple),
          labelText: "Apellidos",
        ),
        onSaved: (value) => _apellido = value,
        validator: (value) {
          if (value.length == 0) {
            return 'Ingrese el apellido';
          } else {
            return null;
          }
        },
      ),
    );
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
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = new RegExp(pattern);
          if (value.length == 0) {
            return "El correo es necesario";
          } else if (!regExp.hasMatch(value)) {
            return "Correo invalido";
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
          if (value.length <= 6) {
            return "La contraseña debe ser mayor a 6 caracteres";
          } else if (value.length < 1) {
            return 'Ingrese la contraseña';
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
            "Guardar",
          )),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: _submit,
    );
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        var user =
            new RegistroModel(_nombre, _apellido, _email, _password, null);
        var db = new DBProvider();
        db.saveUser(user);
        _isLoading = false;
        Navigator.of(context).pushNamed("login");
      });
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
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
          padding: EdgeInsets.only(top: 50.0),
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
