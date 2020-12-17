import 'package:flutter/material.dart';

import 'package:reservaciones_app/src/components/menu_drawer.dart';
import 'package:reservaciones_app/src/providers/espacios_provider.dart';
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
        body: _listaEspacios(),
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

  Widget _listaEspacios() {
    return FutureBuilder(
      future: espaciosProvider.cargarDatos(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(
          children: _itemsEspacios(snapshot.data, context),
        );
      },
    );
  }

  List<Widget> _itemsEspacios(List<dynamic> data, BuildContext context) {
    final List<Widget> items = [];
    data.forEach((element) {
      final widgetTemp = Card(
        child: ListTile(
          leading: Icon(Icons.apartment),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text(element['edificio']),
          subtitle: Text(element['Descripcion']),
          onTap: () {
            Navigator.pushNamed(context, 'espacioDetalle', arguments: element);
          },
        ),
      );

      items.add(widgetTemp);
    });

    return items;
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
