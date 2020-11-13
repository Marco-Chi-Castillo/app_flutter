import 'package:flutter/material.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';

class FormEspacioPage extends StatefulWidget {
  @override
  _FormEspacioPageState createState() => _FormEspacioPageState();
}

class _FormEspacioPageState extends State<FormEspacioPage> {
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
    return Container(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Form(
              child: Column(
                children: <Widget>[
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
