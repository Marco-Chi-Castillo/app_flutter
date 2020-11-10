import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff712634),
          title: Text('ITSVA'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              _drawerHeader(),
              ListTile(
                title: Text('Espacios'),
                leading: Icon(Icons.home_work),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('Espacios'),
                leading: Icon(Icons.home_work),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('Espacios'),
                leading: Icon(Icons.home_work),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('Espacios'),
                leading: Icon(Icons.home_work),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Center(
          child: Text('Hello world'),
        ),
      ),
    );
  }

  DrawerHeader _drawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Color(0xff712634),
      ),
      child: Column(
        children: <Widget>[
          Image(
            height: 100,
            width: 100,
            image: AssetImage('assets/images/logo_itsva.png'),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              'Reservación de Espacios',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
