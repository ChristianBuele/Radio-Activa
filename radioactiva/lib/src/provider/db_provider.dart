import 'dart:io';
import 'package:radioactiva/src/models/notificaciones.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db =
      DBProvider._(); //constructor privado para que no se reinicie la propiedad
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ScansBD.db');
    return await openDatabase(path,
        version: 1, //segun se creen tablas se aumenta la version
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE NOTIFICACIONES ('
          'id INTEGER PRIMARY KEY,'
          'titulo TEXT,'
          'mensaje TEXT,'
          'cuerpo TEXT'
          ')');
    });
  }

  nuevoNotificacionRow(NotificacionesModel modelo) async {
    final db = await database;

    final res = await db.rawInsert(
        "INSERT INTO NOTIFICACIONES VALUES (id, titulo,mensaje,cuerpo) "
        "VALUES ( ${modelo.id}, '${modelo.titulo}', '${modelo.mensaje}', '${modelo.cuerpo}')");
    return res;
  }

  Future<List<NotificacionesModel>> getTodosScans() async {
    final db = await database;
    final resp = await db.query('NOTIFICACIONES');
    List<NotificacionesModel> list = resp.isNotEmpty
        ? resp.map((e) => NotificacionesModel.fromJson(e)).toList()
        : [];
    return list;
  }

  //eliminar
  deleteScan(int id) async {
    final db = await database;
    final res =
        await db.delete('NOTIFICACIONES', where: 'id = ? ', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete("delete from NOTIFICACIONES");
    return res;
  }

  nuevoScan(NotificacionesModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('NOTIFICACIONES', nuevoScan.toJson()); //toJson
    return res;
  }
}
