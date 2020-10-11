import 'package:flutter/material.dart';
import 'package:radioactiva/src/models/menu_widget.dart';
import 'package:radioactiva/src/provider/push_notification.dart';
import 'package:radioactiva/src/utils/preferencias.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _colorSecundario = false;
  double calidad = 0;
  final prefs = new PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    _colorSecundario = prefs.colorSecundario;
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
          Form(
            key: formKey,
            child: Column(
              children: [
                crearTituloNotificacion(),
                crearMensaje(),
                _crearBoton(),
              ],
            ),
          )
        ],
      ),
      drawer: MenuWidget(),
    );
  }

  crearTituloNotificacion() {
    return TextFormField(
      initialValue: 'titulo notificacion',
      decoration: InputDecoration(
        labelText: 'Titulo',
      ),
      textCapitalization: TextCapitalization.sentences,
      onSaved: (newValue) {
        tituloMensaje = newValue;
        print('el nuevo titulo es $tituloMensaje');
      },
      validator: (value) {
        if (value.length < 3) {
          setState(() {});
          return 'Ingrese el nombre del producto';
        }
        tituloMensaje = value;
        return null;
      },
    );
  }

  String tituloMensaje;
  String cuerpoMensaje;
  crearMensaje() {
    return TextFormField(
      initialValue: 'Cuerpo',
      decoration: InputDecoration(
        labelText: 'Mensaje',
      ),
      textCapitalization: TextCapitalization.sentences,
      onSaved: (newValue) {
        cuerpoMensaje = newValue;
        print('el nuevo cuerpo es $cuerpoMensaje');
      },
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el mensaje de la notiificaicon';
        }
        cuerpoMensaje = value;
        return null;
      },
    );
  }

  bool _guardando = false;
  final formKey = GlobalKey<FormState>(); //para validar los formularios
  final scaffoldKey = GlobalKey<ScaffoldState>();
  _crearBoton() {
    return RaisedButton.icon(
      onPressed: (_guardando) ? null : _submit,
      label: Text('Guardar'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save),
    );
  }

  void _submit() async {
    if (formKey.currentState.validate()) {
      final send = PushNotificationsProvider();
      send.enviarNotificaciones(tituloMensaje, cuerpoMensaje);
      mostrarSnackBar('Notificaciones Enviadas', context);
      formKey.currentState.save();
    } else {
      mostrarSnackBar('Verifique los datos', context);
    }

    // Navigator.pop(context);
  }

  void mostrarSnackBar(String mensaje, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Notificaciones'),
            content: Text(mensaje),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('ok'))
            ],
          );
        });
  }
}
