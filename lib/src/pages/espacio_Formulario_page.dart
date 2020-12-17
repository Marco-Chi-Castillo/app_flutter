import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';
import 'package:image_picker/image_picker.dart';

class FormEspacioPage extends StatefulWidget {
  @override
  _FormEspacioPageState createState() => _FormEspacioPageState();
}

class _FormEspacioPageState extends State<FormEspacioPage> {
  File foto;
  String fotoUrl;
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final dynamic espacio = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Scaffold(
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
              child: Column(
                children: <Widget>[
                  _mostrarFoto(),
                  _inputNombre(),
                  _inputDescripcion(),
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
    /*foto = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (foto != null) {
      //Limpieza
    }

    setState(() {});*/
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    /*foto = await ImagePicker.pickImage(source: ImageSource.camera);
    if (foto != null) {
      //Limpieza
    }

    setState(() {});*/
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
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Espacio',
      ),
    );
  }

  Widget _inputDescripcion() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripción',
      ),
    );
  }

  Widget _radioButtons() {
    return Row(
      children: [
        ButtonBar(
          children: [
            Text('Disponible: '),
            Radio(
              value: 1,
              groupValue: selectedRadio,
              onChanged: (val) {
                setSelectedRadio(val);
              },
            ),
            Text('Si'),
            Radio(
              value: 2,
              groupValue: selectedRadio,
              onChanged: (val) {
                setSelectedRadio(val);
              },
            ),
            Text('No'),
          ],
        ),
      ],
    );
  }

  Widget _buttonGuardar() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Style.colorPrimary,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: () {},
    );
  }
}
