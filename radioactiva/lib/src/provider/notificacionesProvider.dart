import 'dart:async';

import 'package:radioactiva/src/models/notificaciones.dart';
import 'package:radioactiva/src/provider/db_provider.dart';

class NotificacionesProvider {
  static final NotificacionesProvider _singleton =
      new NotificacionesProvider._internal();

  factory NotificacionesProvider() {
    return _singleton;
  }
  NotificacionesProvider._internal();

  StreamController<List<NotificacionesModel>> _notificacionesController =
      StreamController<List<NotificacionesModel>>.broadcast();

  Stream<List<NotificacionesModel>> get notificacion =>
      _notificacionesController.stream;

  //obtener toda la info de los scans
  obtenerScans() async {
    _notificacionesController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScan(NotificacionesModel notificacionesModel) async {
    await DBProvider.db.nuevoScan(notificacionesModel);
    obtenerScans();
  }

  borrarScans(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarScansTodos() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }

  dispose() {
    _notificacionesController.close();
  }
}
