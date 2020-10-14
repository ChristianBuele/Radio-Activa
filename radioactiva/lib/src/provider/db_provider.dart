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
    if (_database != null) {
      print('la base de datos ya esta creada y se devuelve');
      return _database;
    }

    _database = await initDB();
    List<Map> x =
        await _database.rawQuery('SELECT * FROM NOTIFICACIONESRADIOACTIVAX');
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ScansBD.db');
    return await openDatabase(path,
        version: 1, //segun se creen tablas se aumenta la version
        onOpen: (db) {
      print(
          "=====================ya esta creada la base de datos y solo arranca=============");
    }, onCreate: (Database db, int version) async {
      print("==========creando la base de datos===========");
      await db.execute('CREATE TABLE NOTIFICACIONESRADIOACTIVAX ('
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
        "INSERT INTO NOTIFICACIONESRADIOACTIVAX VALUES (id, titulo,mensaje,cuerpo) "
        "VALUES ( ${modelo.id}, '${modelo.titulo}', '${modelo.mensaje}', '${modelo.cuerpo}')");
    return res;
  }

  Future<List<NotificacionesModel>> getTodosScans() async {
    final db = await database;
    final resp = await db.query('NOTIFICACIONESRADIOACTIVAX');
    List<NotificacionesModel> list = resp.isNotEmpty
        ? resp.map((e) => NotificacionesModel.fromJson(e)).toList()
        : [];
    return list;
  }

  //eliminar
  deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('NOTIFICACIONESRADIOACTIVAX',
        where: 'id = ? ', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete("delete from NOTIFICACIONESRADIOACTIVAX");
    return res;
  }

  nuevoScan(NotificacionesModel nuevoScan) async {
    final db = await database;
    final res = await db.insert(
        'NOTIFICACIONESRADIOACTIVAX', nuevoScan.toJson()); //toJson
    return res;
  }
}
