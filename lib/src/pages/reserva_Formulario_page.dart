import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reservaciones_app/src/models/reservas_models.dart';
import 'package:reservaciones_app/src/providers/espacio_list_provider.dart';
import 'package:reservaciones_app/src/providers/reserva_list_provider.dart';
import 'package:reservaciones_app/src/providers/reservas_provider.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';
import 'package:intl/intl.dart';

class FormReservaPage extends StatefulWidget {
  @override
  _FormReservaPageState createState() => _FormReservaPageState();
}

class _FormReservaPageState extends State<FormReservaPage> {
  ReservasModel dateModel = new ReservasModel();
  ReservasModel reserva = new ReservasModel();
  String fecha;
  String horaInicial;
  String horaFinal;
  TimeOfDay date3;
  bool _guardando = false;

  final formKey = GlobalKey<FormState>();
  final scaffolKey = GlobalKey<ScaffoldState>();

  // DateTimePicker dateTime = new DateTimePicker();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final espaciosListProvider = Provider.of<EspacioListProvider>(context);
    espaciosListProvider.getAllEspacios();

    final ReservasModel reservasData =
        ModalRoute.of(context).settings.arguments;
    if (reservasData != null) {
      reserva = reservasData;
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _dropDown(espaciosListProvider),
                  SizedBox(height: 30.0),
                  _inputFecha(),
                  _inputHoraInicial(),
                  _inputHoraFinal(),
                  SizedBox(height: 16.0),
                  _inputDetalle(),
                  _inputNumeroAsistentes(),
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

  Widget _dropDown(EspacioListProvider espaciosListProvider) {
    final _espaciosList = espaciosListProvider.espacios;

    return DropdownButtonFormField(
      value: reserva.idEspacio,
      items: _espaciosList
          .map((esp) => DropdownMenuItem(
                child: Text(esp.nombre),
                value: esp.id,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          reserva.idEspacio = value;
        });
      },
      hint: Text('Selecione Espacio'),
      validator: (value) {
        if (value == null) {
          return 'Ingrese un Espacio';
        } else {
          return null;
        }
      },
    );
  }

  Widget _inputFecha() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Fecha de Reservacion: '),
          Text(reserva.fechaReservacion),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Style.colorPrimary),
            icon: Icon(Icons.calendar_today),
            label: Text(''),
            onPressed: () {
              showDatePicker(
                context: context,
                locale: const Locale('es', 'ES'),
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                helpText: 'Selecciona la Fecha',
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light(), // This will change to light theme.
                    child: child,
                  );
                },
              ).then((date) {
                setState(() {
                  fecha = DateFormat('yyyy-MM-dd').format(date).toString();

                  reserva.fechaReservacion = fecha;
                });
              });
            },
          ),
        ]);
  }

  Widget _inputHoraInicial() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Hora de Inicio: '),
          Text(reserva.horaInicio),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Style.colorPrimary),
            icon: Icon(Icons.access_time),
            label: Text(''),
            onPressed: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: DateTime.now().hour, minute: 00),
                helpText: 'Selecciona la Hora Inicial',
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child,
                  );
                },
              ).then((data) {
                setState(() {
                  horaInicial = data.format(context);
                  reserva.horaInicio =
                      _convertirHoraInicio(horaInicial).toString();
                });
              });
            },
          ),
        ]);
  }

  Widget _inputHoraFinal() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Hora de Termino: '),
          Text(reserva.horaFinal),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Style.colorPrimary),
            icon: Icon(Icons.access_time),
            label: Text(''),
            onPressed: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: DateTime.now().hour, minute: 00),
                helpText: 'Selecciona la Hora Final',
                builder: (BuildContext context, Widget child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: child,
                  );
                },
              ).then((data2) {
                setState(() {
                  horaFinal = data2.format(context); //normal
                  reserva.horaFinal = _convertirHoraFinal(horaFinal); //bd
                });
              });
            },
          ),
        ]);
  }

  Widget _inputDetalle() {
    return TextFormField(
      initialValue: reserva.detalle,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Detalle',
      ),
      onSaved: (value) => reserva.detalle = value,
    );
  }

  Widget _inputNumeroAsistentes() {
    return TextFormField(
      initialValue: reserva.numAsistentes.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Número de asistentes',
      ),
      onSaved: (value) => reserva.numAsistentes = int.parse(value),
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

  String _convertirHoraInicio(String hora) {
    String horaConvertida;
    List<String> horas = hora.split(":");

    if (horas[0].length == 1) {
      horas[0] = "0" + horas[0];
    }

    horaConvertida = horas[0] + ":" + horas[1] + ":00";
    return horaConvertida;
  }

  String _convertirHoraFinal(String hora) {
    String horaConvertida;
    int horaTemp;
    List<String> horas = hora.split(":");

    if (horas[0] == "0") {
      horas[0] = "23";
    } else {
      horaTemp = int.parse(horas[0]);
      horaTemp--;
      horas[0] = horaTemp.toString();
      if (horas[0].length == 1) {
        horas[0] = "0" + horas[0];
      }
    }

    horaConvertida = horas[0] + ":59:00";
    return horaConvertida;
  }

  Future<void> _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    final productoProvider =
        Provider.of<ReservaListProvider>(context, listen: false);

    reserva.idUsuario = ReservasProvider.rpro.getUsuarioId();

    if (reserva.id == null) {
      if (reserva.fechaReservacion != '' &&
          reserva.horaInicio != '' &&
          reserva.horaFinal != '') {
          final resp =await productoProvider.insertReserva(reserva);
          if(resp!=null){
            setState(() {
              _guardando = true;
            });
            mostrarSnackbar('Reserva guardada');
            new Timer(new Duration(milliseconds: 2000), (){
             
            });
            
            //Navigator.pushReplacementNamed(context, 'reservaciones');
            Navigator.pop(context);
          }else {
            mostrarSnackbar('Espacio ya reservado en esa fecha y hora');
          }
         /* productoProvider.insertReserva(reserva).then((value) {
          if (value != null) {
            setState(() {
              _guardando = true;
            });
            mostrarSnackbar('Reserva guardada');
            Navigator.pushReplacementNamed(context, 'reservaciones');
          } else {
            mostrarSnackbar('Espacio ya reservado en esa fecha y hora');
          }
        });*/
      } else {
         mostrarSnackbar('Por favor ingrese todos los datos');
      }
    } else {
      await productoProvider.updateReserva(reserva);
      Navigator.pushReplacementNamed(context, 'reservaciones');
    }
  }

  void mostrarSnackbar(String mensaje){
    final snackbar = SnackBar(
        content: Text(mensaje),
        duration: Duration(
          milliseconds: 2000,
        ));

    scaffolKey.currentState.showSnackBar(snackbar);
  }
}
