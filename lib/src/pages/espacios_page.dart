import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reservaciones_app/src/components/menu_drawer.dart';
import 'package:reservaciones_app/src/providers/espacio_list_provider.dart';
import 'package:reservaciones_app/src/utils/paletaColor_util.dart';

class EspaciosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Espacios ITSVA'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //Aquí debo llamar al datasearch
                showSearch(context: context, delegate: DataSearch());
              },
            )
          ],
        ),
        drawer: Drawer(
          child: menuDrawer.menuDrawer(),
        ),
        body: _listaEspacios(context),
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

  Widget _listaEspacios(BuildContext context) {
    final espaciosListProvider = Provider.of<EspacioListProvider>(context);
    espaciosListProvider.getAllEspacios();

    final espacios = espaciosListProvider.espacios;

    return ListView.builder(
      itemCount: espacios.length,
      itemBuilder: (_, i) => ListTile(
        leading: Icon(Icons.apartment),
        trailing: Icon(Icons.keyboard_arrow_right),
        title: Text(espacios[i].nombre),
        subtitle: Text(espacios[i].descripcion),
        onTap: () {
          Navigator.pushNamed(context, 'espacioDetalle',
              arguments: espacios[i]);
        },
      ),
    );
  }
}

//Class DataSearch
class DataSearch extends SearchDelegate<String> {
  final reservationsites = [
    "Audiovisual 1",
    "Audiovisual 2",
    "Centro de cómputo 1",
    "Centro de cómputo 2",
    "Centro de cómputo 3",
    "Centro de cómputo 4",
    "Auditorio",
    "Sala de juntas 1",
    "Sala de juntas 2",
  ];

  final recentReservation = [
    "Centro de cómputo 1",
    "Centro de cómputo 2",
    "Audiovisual 1",
    "Sala de juntas 2",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
//Actions for appBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
//Leading icon on the left of the AppBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
// show some result based on the selection
    return Center(
        child: Container(
            height: 100.0,
            width: 100.0,
            color: Colors.green,
            child: Center(
              child: Text(query),
            )));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
//Show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentReservation //Reservaciones recientes
        : reservationsites.where((p) => p.startsWith(query)).toList();
    //Reservaciones
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.apartment),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
