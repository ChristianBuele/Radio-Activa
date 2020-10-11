import 'dart:async';

import 'package:flutter/material.dart';
import 'package:radioactiva/src/provider/notificacionesProvider.dart';
import 'package:radioactiva/src/utils/preferencias.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:radioactiva/src/utils/colores.dart' as color;

class NavegadorPage extends StatefulWidget {
  @override
  _NavegadorPageState createState() => _NavegadorPageState();
}

class _NavegadorPageState extends State<NavegadorPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();
  final prefs = PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context).settings.arguments;
    //para recibir los argumentos del otro lado
    final titulo = url.split(',')[1];
    final link = url.split(',')[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (prefs.colorSecundario)
            ? color.appBarColorLight
            : color.appBarColorDark,
        title: Text(titulo),
      ),
      body: cuerpo(link),
      /* key: UniqueKey(),
      appBar: _crearAppBar(titulo),
      body: CustomScrollView(
        slivers: <Widget>[
          //_crearAppBar(titulo),
          SliverFillRemaining(
            child: cuerpo(url),
          )
        ],
      ),*/
    );
  }

  Widget _crearAppBar(String titulo) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: (prefs.colorSecundario)
          ? color.appBarColorLight
          : color.appBarColorDark,
      expandedHeight: 200.0,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          titulo,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(
              'https://res.cloudinary.com/dp3hnmhpg/image/upload/v1602363840/w4zbpx02jbsgmuygly1g.jpg'),
          placeholder: AssetImage('assets/jar-loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  cuerpo(String url) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
