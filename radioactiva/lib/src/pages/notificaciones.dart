import 'package:flutter/material.dart';
import 'package:radioactiva/src/models/notificaciones.dart';
import 'package:radioactiva/src/provider/notificacionesProvider.dart';
import 'package:radioactiva/src/utils/preferencias.dart';
import 'package:radioactiva/src/utils/colores.dart' as color;

class NotificacionesPage extends StatefulWidget {
  @override
  _NotificacionesPageState createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  NotificacionesProvider scansBloc = new NotificacionesProvider();
  @override
  void initState() {
    scansBloc.estadoNotificacion(false);
    notificacionesProvider = NotificacionesProvider();
    super.initState();
  }

  final prefs = new PreferenciasUsuario();
  NotificacionesProvider notificacionesProvider;
  @override
  Widget build(BuildContext context) {
    final scansBlock = new NotificacionesProvider();
    final scan = new NotificacionesProvider();
    scan.obtenerScans();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: prefs.colorSecundario
            ? color.appBarColorLight
            : color.appBarColorDark,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              scansBlock.borrarScansTodos();
            },
          )
        ],
      ),
      body: crearNotificaciones(),
    );
  }

  crearNotificaciones() {
    return StreamBuilder<List<NotificacionesModel>>(
      stream: notificacionesProvider.notificacion,
      builder: (context, AsyncSnapshot<List<NotificacionesModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final notificaciones = snapshot.data;
        if (notificaciones.length == 0) {
          return Center(
            child: Text('Sin notificaciones'),
          );
        }
        return ListView.builder(
          itemCount: notificaciones.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            child: ListTile(
              //  tileColor: color.appBarColorLight,
              leading: Image.asset('assets/logo.png'),
              title: Text(notificaciones[i].titulo),
              subtitle: Text(notificaciones[i].mensaje),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () => Navigator.pop(context),
            ),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (e) {
              notificacionesProvider.borrarScans(notificaciones[i].id);
            },
          ),
        );
      },
    );
  }
}
