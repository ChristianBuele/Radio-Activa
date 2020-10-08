import 'package:flutter/material.dart';
import 'package:radioactiva/src/pages/config_page.dart';
import 'package:radioactiva/src/pages/home_page.dart';
import 'package:radioactiva/src/pages/prueba.dart';
import 'package:radioactiva/src/pages/radio_page.dart';
import 'package:radioactiva/src/pages/radio_pagepro.dart';
import 'package:radioactiva/src/pages/settings_page.dart';
import 'package:radioactiva/src/pages/video_page.dart';
import 'package:radioactiva/src/utils/preferencias.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Radio Activa',
      initialRoute: 'home',
      routes: {
        'radio': (BuildContext c) => RadioPage(),
        'video': (BuildContext c) => VideoPage(),
        'home': (BuildContext c) => HomePage(),
        'settings': (BuildContext c) => SettingsPage(),
        'config': (BuildContext c) => ConfiguracionPage(),
        'radioPro': (BuildContext c) => MyHomePage()
      },
      theme: ThemeData(primaryColor: Color.fromRGBO(193, 53, 85, 1)),
    );
  }
}
