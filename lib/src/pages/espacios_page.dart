import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reservaciones_app/src/components/menu_drawer.dart';
import 'package:reservaciones_app/src/models/espacios_model.dart';
import 'package:reservaciones_app/src/providers/espacio_list_provider.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';

class EspaciosPage extends StatefulWidget {
  @override
  _EspaciosPageState createState() => _EspaciosPageState();
}

class _EspaciosPageState extends State<EspaciosPage> {
  List<EspaciosModel> espaciosFilter = new List();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final espaciosListProvider = Provider.of<EspacioListProvider>(context);
    espaciosListProvider.getAllEspacios();

    final espacios = espaciosListProvider.espacios;
    //espaciosFilter = espacios;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Espacios ITSVA'),
        ),
        drawer: Drawer(
          child: menuDrawer.menuDrawer(),
        ),
        body: Column(
          children: [
            _inputSearch(espacios),
            SizedBox(height: 10.0),
            _listaEspacios(context, espacios),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'formEspacio');
          },
          child: Icon(Icons.add),
          backgroundColor: Style.colorPrimary,
        ),
      ),
    );
  }

  Widget _inputSearch(List<EspaciosModel> espacios) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          hintText: 'Ingresa nombre del espacio',
          icon: Icon(Icons.search),
        ),
        onChanged: (string) {
          setState(() {
            espaciosFilter = espacios
                .where((e) =>
                    (e.nombre.toLowerCase().contains(string.toLowerCase())))
                .toList();
          });
        },
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
    );
  }

  Widget _listaEspacios(BuildContext context, List<EspaciosModel> espacios) {
    return Expanded(
      child: ListView.builder(
        itemCount: espaciosFilter.length == 0
            ? espacios.length
            : espaciosFilter.length,
        itemBuilder: (_, i) => ListTile(
          /*leading: FadeInImage(
            image: NetworkImage(espacios[i].imagen),
            placeholder: AssetImage('assets/images/jar-loading.gif'),
            height: 100.0,
            width: double.infinity,
            fit: BoxFit.cover,
          )*/

          leading: Icon(Icons.apartment),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(espaciosFilter.length == 0
              ? espacios[i].nombre
              : espaciosFilter[i].nombre),
          subtitle: Text(espaciosFilter.length == 0
              ? espacios[i].descripcion
              : espaciosFilter[i].descripcion),
          onTap: () {
            Navigator.pushNamed(context, 'espacioDetalle',
                arguments: espaciosFilter.length == 0
                    ? espacios[i]
                    : espaciosFilter[i]);
          },
        ),
      ),
    );
    /*
    */
  }
}
