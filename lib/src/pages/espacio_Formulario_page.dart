import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaciones_app/src/models/espacios_model.dart';
import 'package:reservaciones_app/src/providers/edificio_list_provider.dart';
import 'package:reservaciones_app/src/providers/espacio_list_provider.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';
import 'package:image_picker/image_picker.dart';

class FormEspacioPage extends StatefulWidget {
  @override
  _FormEspacioPageState createState() => _FormEspacioPageState();
}

class _FormEspacioPageState extends State<FormEspacioPage> {
  File foto;
  String fotoUrl;
  bool _guardando = false;

  final formKey = GlobalKey<FormState>();
  final scaffolKey = GlobalKey<ScaffoldState>();
  EspaciosModel espacio = new EspaciosModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final edificiosListProvider = Provider.of<EdificioListProvider>(context);
    edificiosListProvider.getAllEdificios();

    final EspaciosModel espacioData = ModalRoute.of(context).settings.arguments;
    if (espacioData != null) {
      espacio = espacioData;
    }
    //final dynamic espacio = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Scaffold(
        key: scaffolKey,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _seleccionarFoto,
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: _tomarFoto,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _mostrarFoto(),
                  _inputNombre(),
                  _inputDescripcion(),
                  _inputCapacidad(),
                  SizedBox(height: 30.0),
                  _dropDown(edificiosListProvider),
                  SizedBox(height: 30.0),
                  _radioButtons(),
                  _buttonGuardar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Donde se almacena la foto
  Widget _mostrarFoto() {
    if (fotoUrl != null) {
      return Container();
    } else {
      if (foto != null) {
        return Image.file(foto, height: 300.0, fit: BoxFit.cover);
      }
      return Image.asset('assets/images/no-image.png');
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      //Limpieza
    }
    setState(() {});
  }

  Widget _inputNombre() {
    return TextFormField(
      initialValue: espacio.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Espacio',
      ),
      onSaved: (value) => espacio.nombre = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese el nombre del espacio';
        } else {
          return null;
        }
      },
    );
  }

  Widget _inputDescripcion() {
    return TextFormField(
      initialValue: espacio.descripcion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripción',
      ),
      onSaved: (value) => espacio.descripcion = value,
    );
  }

  Widget _inputCapacidad() {
    return TextFormField(
      initialValue: espacio.capacidad.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Capacidad',
      ),
      onSaved: (value) => espacio.capacidad = int.parse(value),
    );
  }

  Widget _radioButtons() {
    return SwitchListTile(
      value: espacio.estatus == 1 ? true : false,
      title: Text('Disponible'),
      onChanged: (value) => setState(() {
        espacio.estatus = value == true ? 1 : 0;
      }),
    );
  }

  Widget _dropDown(EdificioListProvider edificiosListProvider) {
    final _edificiosList = edificiosListProvider.edificio;

    return DropdownButtonFormField(
      value: espacio.idEdificio,
      items: _edificiosList
          .map((edi) => DropdownMenuItem(
                child: Text(edi.nombre),
                value: edi.id,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          espacio.idEdificio = value;
        });
      },
      hint: Text('Selecione Edificio'),
      validator: (value) {
        if (value == null) {
          return 'Ingrese un Edificio';
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

    final espacioProvider =
        Provider.of<EspacioListProvider>(context, listen: false);

    espacio.imagen = 'assets/im7.jpg';

    if (espacio.id == null) {
      espacioProvider.insertEspacio(espacio);
    } else {
      espacioProvider.updateEspacio(espacio);
    }
    mostrarSnackbar('Espacio Guardado');
    Navigator.pushNamed(context, 'espacios');
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
