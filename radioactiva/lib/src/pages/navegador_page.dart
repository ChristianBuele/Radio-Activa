import 'package:flutter/material.dart';
import 'package:radioactiva/src/utils/preferencias.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:radioactiva/src/utils/colores.dart' as color;

class NavegadorPage extends StatefulWidget {
  @override
  _NavegadorPageState createState() => _NavegadorPageState();
}

class _NavegadorPageState extends State<NavegadorPage> {
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

  cuerpo(String url) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
