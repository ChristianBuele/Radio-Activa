import 'package:flutter/material.dart';
import 'package:radioactiva/src/pages/prueba.dart';
import 'package:radioactiva/src/pages/radio_pagepro.dart';
import 'package:radioactiva/src/pages/settings_page.dart';
import 'package:radioactiva/src/pages/video_page.dart';

class Pantalla extends StatefulWidget {
  @override
  _PantallaState createState() => _PantallaState();
}

class _PantallaState extends State<Pantalla> {
  int currentIndex = 0;
  int indexAux = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(''),
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_active), onPressed: () {})
        ],
      ),
      body: _callPage(indexAux),
      bottomNavigationBar: _menuInferior(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            indexAux = 2;
            print('RADIO MODE');
          });
        },
        child: Icon(Icons.radio),
        backgroundColor: Color.fromRGBO(182, 50, 84, 1),
      ),
      drawer: crearDrawer(context),
    );
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return VideoPage();
      case 1:
        return SettingsPage();
      default:
        return MyHomePage();
    }
  }

  _menuInferior(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(228, 103, 107, 1),
      currentIndex: currentIndex, // le dice al elemento activo
      onTap: (index) {
        setState(() {
          currentIndex = index;
          indexAux = index;
          print('El indes es :$index');
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.live_tv_sharp,
            color: Colors.white,
          ),
          label: 'live',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.brightness_5,
              color: Colors.white,
            ),
            label: 'Settins'),
      ],
    );
  }

  crearDrawer(BuildContext context) {
    return Drawer(
        elevation: 1.0,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(203, 8, 42, 1),
            Color.fromRGBO(177, 51, 73, 1)
          ], end: Alignment(0.8, 0.0))),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Container(
                        child: Image.asset('assets/logo.png'),
                      ),
                    ),
                    Text(
                      'Síguenos en nuestras redes',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/f-01.png'),
                ),
                title: Text(
                  'Facebook',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  //Navigator.pushReplacementNamed(context, HomePagePa);
                  print('FACEBOOK');
                },
                subtitle: Text('@radioactivafan',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/t-01.png'),
                ),
                title: Text(
                  'Twiter',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  //Navigator.pushReplacementNamed(context, HomePagePa);
                  print('Twiter');
                },
                subtitle: Text('@radioactivafan',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/i-01.png'),
                ),
                title: Text(
                  'Instagram',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  //Navigator.pushReplacementNamed(context, HomePagePa);
                  print('FACEBOOK');
                },
                subtitle: Text('@radioactivafan',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              )
            ],
          ),
        ));
  }
}
