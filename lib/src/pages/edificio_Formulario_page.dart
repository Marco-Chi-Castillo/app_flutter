import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaciones_app/src/models/edificios_model.dart';
import 'package:reservaciones_app/src/providers/edificio_list_provider.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';

class FormEdificioPage extends StatefulWidget {
  @override
  _FormEdificioPageState createState() => _FormEdificioPageState();
}

class _FormEdificioPageState extends State<FormEdificioPage> {
  bool _guardando = false;
  final formKey = GlobalKey<FormState>();
  final scaffolKey = GlobalKey<ScaffoldState>();

  EdificiosModel edificio = new EdificiosModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final EdificiosModel edificioData =
        ModalRoute.of(context).settings.arguments;
    if (edificioData != null) {
      edificio = edificioData;
    }
    //final dynamic espacio = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Scaffold(
        key: scaffolKey,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _inputNombre(),
                  SizedBox(height: 30.0),
                  _buttonGuardar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputNombre() {
    return TextFormField(
      initialValue: edificio.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Edificio',
      ),
      onSaved: (value) => edificio.nombre = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese el nombre del edificio';
        } else {
          return null;
        }
      },
    );
  }

  Widget _buttonGuardar() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Style.colorPrimary,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    final productoProvider =
        Provider.of<EdificioListProvider>(context, listen: false);

    if (edificio.id == null) {
      productoProvider.insertEdificio(edificio);
    } else {
      productoProvider.updateEdificio(edificio);
    }
    mostrarSnackbar('Edificio Guardado');
    Navigator.pushNamed(context, 'edificios');
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
        content: Text(mensaje),
        duration: Duration(
          milliseconds: 2000,
        ));

    scaffolKey.currentState.showSnackBar(snackbar);
  }
}
