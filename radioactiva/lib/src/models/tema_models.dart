import 'package:flutter/material.dart';
import 'package:radioactiva/src/pages/radio_pagepro.dart';
import 'package:radioactiva/src/pages/settings_page.dart';
import 'package:radioactiva/src/pages/video_page.dart';
import 'package:radioactiva/src/utils/preferencias.dart';
import 'package:radioactiva/src/utils/colores.dart' as color;

class Pantalla extends StatefulWidget {
  @override
  _PantallaState createState() => _PantallaState();
}

class _PantallaState extends State<Pantalla> {
  final prefs = new PreferenciasUsuario();
  bool _colorSecundario = false;
  int currentIndex = 0;
  int indexAux = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text(''),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.notifications_active),
                onPressed: () {
                  Navigator.pushNamed(context, 'notificaciones');
                })
          ],
          backgroundColor: (prefs.colorSecundario)
              ? color.appBarColorLight
              : color.appBarColorDark),
      body: _callPage(indexAux),
      bottomNavigationBar: _menuInferior(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: (prefs.colorSecundario)
            ? color.appBarColorLight
            : color.appBarColorDark,
        heroTag: 'btnGomes',
        onPressed: () {
          setState(() {
            indexAux = 2;
            print('RADIO MODE');
          });
        },
        child: Icon(Icons.radio),
        // backgroundColor: Color.fromRGBO(182, 50, 84, 1),
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
        return RadioPageLight();
    }
  }

  _menuInferior(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: (prefs.colorSecundario)
          ? color.appBarColorLight
          : color.appBarColorDark,
      currentIndex: currentIndex,
      selectedItemColor: color.textoLight,
      unselectedItemColor: color.gris,
      // le dice al elemento activo
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
            Icons.ondemand_video,
          ),
          label: 'Live',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.brightness_5,
            ),
            label: 'Settings'),
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
              Divider(
                color: Colors.white,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/f-01.png'),
                ),
                title: Text(
                  'Faceboooook',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'navegador',
                      arguments:
                          'https://www.facebook.com/radioactivafan,Facebook');
                  print('FACEBOOK');
                },
                subtitle: Text('@radioactivafan',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/t-01.png'),
                ),
                title: Text(
                  'Twiter',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'navegador',
                      arguments: 'https://twitter.com/radioactivafan,Twiter');
                  print('Twiter');
                },
                subtitle: Text('@radioactivafan',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/i-01.png'),
                ),
                title: Text(
                  'Instagram',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'navegador',
                      arguments:
                          'https://pub.dev/packages/flutter_webview_plugin,Instragram');
                  print('FACEBOOK');
                },
                subtitle: Text('@radioactivafan',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Acerca del Desarrolador',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _colorSecundario = prefs.colorSecundario;
  }
}
