import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:radioactiva/src/models/notificaciones.dart';
import 'package:radioactiva/src/provider/notificacionesProvider.dart';
import 'package:radioactiva/src/provider/productos_provider.dart';
import 'package:radioactiva/src/utils/preferencias.dart';

class PushNotificationsProvider {
  static final PushNotificationsProvider _singleton =
      new PushNotificationsProvider._internal();

  factory PushNotificationsProvider() {
    return _singleton;
  }
  PushNotificationsProvider._internal();
  final scansBloc = new NotificacionesProvider();

  final prefs = new PreferenciasUsuario();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajeStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajesStream => _mensajeStreamController.stream;
  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();
    final token = await _firebaseMessaging.getToken();
    print('token es..... $token');
    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );

    TokenProvider tokenProvider = new TokenProvider();
    print('-----------las prefs son ${prefs.colorSecundario}');
    if (prefs.idUsuario != null) {
      await tokenProvider.actualizarProducto(prefs.idUsuario, token);
    } else {
      await tokenProvider.crearToken(token);
    }

    obtenerDispositivos();
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    final argumento = message['notification'];
    print('llega indo on Message $argumento');
    print('Titulo ${argumento['title']}');
    print('Mensaje ${argumento['body']}');
    print('Cuerpo ${message['data']['cuerpo']}');

    scansBloc.agregarScan(parse(message));
    scansBloc.estadoNotificacion(true);

    // _mensajeStreamController.sink.add(argumento['title'] ?? 'no-data');
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    final argumento = message['notification'];
    print('llega indo on launch $argumento');
    scansBloc.agregarScan(parse(message));
    scansBloc.estadoNotificacion(true);
    //  _mensajeStreamController.sink.add(argumento);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    final argumento = message['notification'];
    print('llega indo on resume $argumento');
    scansBloc.agregarScan(parse(message));
    scansBloc.estadoNotificacion(true);
    //  _mensajeStreamController.sink.add(argumento);
  }

  NotificacionesModel parse(Map<String, dynamic> message) {
    final argumento = message['notification'];
    final modelo = new NotificacionesModel(
        titulo: argumento['title'],
        mensaje: argumento['body'],
        cuerpo: message['data']['cuerpo']);
    return modelo;
  }

  List<String> listaToken = new List();
  dispose() {
    _mensajeStreamController?.close();
  }

  final String serverToken =
      'AAAAJSL6u_8:APA91bE0SYSzrBrYTWs8AXb4nO72G9fUvRMmR45xxh3F5Y6AeIn2MP7Qw6NRRPSNzB1zJzrq72B6bPuCxOS1s8I5PK7JZtrnLJYNE9Oavb7Ov0prKHeO7Zz-8ZvN-i-trwH95LWACnf5';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  enviarNotificaciones(String titulo, String cuerpo, String contenido) async {
    //obtenerDispositivos();
    print('hay ${listaToken.length} dispositivos');
    listaToken.forEach((element) {
      sendNotificaciones(titulo, cuerpo, contenido, element);
    });
  }

  Future<String> sendNotificaciones(
      String titulo, String cuerpo, String contenido, String id) async {
    if (listaToken.isNotEmpty) {
      await firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false),
      );
      print('se enviar notificacion a $id');
      final resp = await http.post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': cuerpo,
              'title': titulo,
              'sound': 'default'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'cuerpo': 'contenido'
            },
            'to': id,
          },
        ),
      );
      final decodedData = json.decode(resp.body);
      print(
          '======llega el mensaje de la notificacion ${decodedData['success']} ======');
      return decodedData['success'].toString();
    }
    return null;
  }

  void obtenerDispositivos() async {
    print("==================obeteniendo");
    final url = 'https://radioactiva-e95ad.firebaseio.com/usuarios.json';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    if (decodedData == null) {
      print('no hay datos de dispositivos');
      listaToken = [];
    } else {
      decodedData.forEach((id, value) {
        print('el token que llega a la lista es ${value['token']}');
        listaToken.add(value['token']);
      });
      print(
          'se termina de cargar los dispositivos con un total de ${listaToken.length}');
    }
  }
}
/*
cUhghfWyTnCPOqiFn9FI-E:APA91bG47PbZZysmLy8JmhtetZtntgmIKqDXtsK9cAVx9oKHs9_m7Fk_peRrcj-5cElE66LL9jsTYTakoDWd3JSfA399t_KS7DmbpcoEJI-WZhB35J8X-rIcudVy1fMqzOe0dChaA8RR
*/
