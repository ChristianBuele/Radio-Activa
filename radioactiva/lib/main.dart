import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radioactiva/src/pages/home_page.dart';
import 'package:radioactiva/src/pages/navegador_page.dart';
import 'package:radioactiva/src/pages/notificaciones.dart';
import 'package:radioactiva/src/pages/radio_pagepro.dart';
import 'package:radioactiva/src/pages/settings_page.dart';
import 'package:radioactiva/src/pages/video_page.dart';
import 'package:radioactiva/src/provider/push_notification.dart';
import 'package:radioactiva/src/provider/videoProider.dart';
import 'package:radioactiva/src/utils/preferencias.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final prefs = new PreferenciasUsuario();
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  VideoBloc videoBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();
    videoBloc = new VideoBloc();
    pushProvider.mensajesStream.listen((event) {
      print('desde main---------------- $event');

      Navigator.pushNamed(context, 'notificaciones');
      // navigatorKey.currentState.pushNamed('notificaciones', arguments: event);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Radio Activa',
      initialRoute: 'home',
      routes: {
        'video': (BuildContext c) => VideoPage(),
        'home': (BuildContext c) => HomePage(),
        'settings': (BuildContext c) => SettingsPage(),
        'radioPro': (BuildContext c) => RadioPageLight(),
        'navegador': (BuildContext c) => NavegadorPage(),
        'notificaciones': (BuildContext c) => NotificacionesPage()
      },
      //theme: ThemeData(primaryColor: Color.fromRGBO(193, 53, 85, 1)),
    );
  }
}
