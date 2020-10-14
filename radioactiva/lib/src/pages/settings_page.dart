import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:radioactiva/src/provider/push_notification.dart';
import 'package:radioactiva/src/utils/preferencias.dart';
import 'package:radioactiva/src/utils/colores.dart' as color;
import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  BuildContext buildContext;
  bool _colorSecundario = false;
  double calidad = 0;
  final prefs = new PreferenciasUsuario();
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _colorSecundario = prefs.colorSecundario;
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),
          SwitchListTile(
              activeColor: prefs.colorSecundario
                  ? color.appBarColorLight
                  : color.appBarColorDark,
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
          Container(
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                'Notificaciones',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  crearTituloNotificacion(),
                  crearMensaje(),
                  // crearContenido(),
                  SizedBox(
                    height: 10,
                  ),
                  _crearBoton(),
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                'Link TV',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
                key: formKeyLink,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Link',
                      ),
                      textCapitalization: TextCapitalization.none,
                      initialValue: link,
                      onSaved: (newValue) {
                        link = newValue;
                        print('el nuevo titulo es $tituloMensaje');
                      },
                      validator: (value) {
                        if (value.length < 3) {
                          setState(() {});
                          return 'Ingrese minimo 3 letras';
                        }
                        link = value;
                        return null;
                      },
                    ),
                    botonActualizarLink(),
                  ],
                )),
          ),
        ],
      ),
      //  drawer: MenuWidget(),
    );
  }

  crearTituloNotificacion() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Título',
      ),
      textCapitalization: TextCapitalization.sentences,
      initialValue: tituloMensaje,
      onSaved: (newValue) {
        tituloMensaje = newValue;
        print('el nuevo titulo es $tituloMensaje');
      },
      validator: (value) {
        if (value.length < 3) {
          setState(() {});
          return 'Ingrese minimo 3 letras';
        }
        tituloMensaje = value;
        return null;
      },
    );
  }

  String tituloMensaje = "";
  String cuerpoMensaje = "";
  String contenido = "";
  String link = "";
  crearMensaje() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Mensaje',
      ),
      textCapitalization: TextCapitalization.sentences,
      initialValue: cuerpoMensaje,
      onSaved: (newValue) {
        cuerpoMensaje = newValue;
        print('el nuevo cuerpo es $cuerpoMensaje');
      },
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el mensaje de la notificación';
        }
        cuerpoMensaje = value;
        return null;
      },
    );
  }

  bool _guardando = false;
  bool _guardandoLink = false;
  final formKey = GlobalKey<FormState>(); //para validar los formularios
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final formKeyLink = GlobalKey<FormState>(); //para validar los formularios
  final scaffoldKeyLink = GlobalKey<ScaffoldState>();
  _crearBoton() {
    return RaisedButton.icon(
      onPressed: (_guardando) ? null : _submit,
      label: Text('Enviar Notificación'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: prefs.colorSecundario
          ? color.appBarColorLight
          : color.appBarColorDark,
      textColor: Colors.white,
      icon: Icon(Icons.send),
    );
  }

  void _submit() async {
    if (formKey.currentState.validate()) {
      print('enviado notigicaion');
      final send = PushNotificationsProvider();
      await send.enviarNotificaciones(tituloMensaje, cuerpoMensaje, contenido);
      mostrarSnackBar('Notificaciones Enviadas', context);
      formKey.currentState.save();
      tituloMensaje = "";
      cuerpoMensaje = "";
      contenido = "";
      setState(() {});
      //Navigator.pushReplacementNamed(context, 'notificaciones');
    } else {
      print('enviado notigicaion else');
      mostrarSnackBar('Verifique los datos', context);
    }
  }

  void _submitLink() async {
    if (formKeyLink.currentState.validate()) {
      print('enviado Link');

      await http.put(
        'https://radioactiva-e95ad.firebaseio.com/enlaces.json',
        body: jsonEncode(
            {"radio": "https://radio.kapchosting.com/9308/stream", "tv": link}),
      );

      mostrarSnackBar('Link Actualizado', context);
      link = "";
      setState(() {});
      formKeyLink.currentState.save();
      // Navigator.pop(context);
      //Navigator.pushReplacementNamed(context, 'notificaciones');
    } else {
      print('enviado notigicaion else');
      mostrarSnackBar('Verifique los datos', context);
    }
  }

  void mostrarSnackBar(String mensaje, BuildContext context) {
    print('mostrando alerta');
    showDialog(
        context: buildContext,
        builder: (context) {
          return AlertDialog(
            title: Text('Atención'),
            content: Text(mensaje),
            actions: [
              FlatButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text('ok'))
            ],
          );
        });
  }

  crearContenido() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Comentario',
      ),
      textCapitalization: TextCapitalization.sentences,
      onSaved: (newValue) {
        contenido = newValue;
        print('el nuevo cuerpo es $cuerpoMensaje');
      },
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el contenido';
        }
        contenido = value;
        return null;
      },
    );
  }

  botonActualizarLink() {
    return RaisedButton.icon(
      onPressed: (_guardandoLink) ? null : _submitLink,
      label: Text('Enviar Notificación'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: prefs.colorSecundario
          ? color.appBarColorLight
          : color.appBarColorDark,
      textColor: Colors.white,
      icon: Icon(Icons.save),
    );
  }
}
