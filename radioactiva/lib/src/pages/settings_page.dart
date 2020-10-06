import 'package:flutter/material.dart';
import 'package:radioactiva/src/models/menu_widget.dart';
import 'package:radioactiva/src/utils/preferencias.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _colorSecundario = false;
  int _genero;
  TextEditingController _textEditingController;
  final prefs = new PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _textEditingController =
        new TextEditingController(text: prefs.nombreUsuario);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          SwitchListTile(
              value: _colorSecundario,
              onChanged: (value) {
                _colorSecundario = value;
                prefs.colorSecundario = value;
                setState(() {});
              },
              title: (_colorSecundario)
                  ? Text('Cambiar a Dark')
                  : Text('Cambiar a Light')),
          Divider(),
        ],
      ),
      drawer: MenuWidget(),
    );
  }
}
