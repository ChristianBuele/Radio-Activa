import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:radioactiva/src/pages/home_page.dart';
import 'package:radioactiva/src/pages/radio_page.dart';
import 'package:radioactiva/src/pages/video_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Radio Activa',
      initialRoute: 'home',
      routes: {
        'radio': (BuildContext c) => RadioPage(),
        'video': (BuildContext c) => VideoPage(),
        'home': (BuildContext c) => HomePage()
      },
      theme: ThemeData(primaryColor: Color.fromRGBO(193, 53, 85, 1)),
    );
  }
}
