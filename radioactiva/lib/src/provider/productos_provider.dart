import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:radioactiva/src/utils/preferencias.dart';

class TokenProvider {
  final String _url = 'https://flutter-72d58.firebaseio.com';
  final _prefs = new PreferenciasUsuario();
  final String serverToken =
      'key=AAAAJSL6u_8:APA91bE0SYSzrBrYTWs8AXb4nO72G9fUvRMmR45xxh3F5Y6AeIn2MP7Qw6NRRPSNzB1zJzrq72B6bPuCxOS1s8I5PK7JZtrnLJYNE9Oavb7Ov0prKHeO7Zz-8ZvN-i-trwH95LWACnf5';
  List<String> usuarios;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
  }
/*
  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json';
    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }*/

  Future<bool> crearToken(String token) async {
    final url = 'https://radioactiva-e95ad.firebaseio.com/usuarios.json';
    final resp = await http.post(url, body: '{"token":"$token"}');
    final decodedData = jsonDecode(resp.body);
    print('el id usuario que llega es ${decodedData['name']}');
    _prefs.idUsuario = decodedData['name'];
    print('el id usuario guardado es ${_prefs.idUsuario}');
    return true;
  }

  Future<bool> actualizarProducto(String idUsuario, String token) async {
    final url =
        'https://radioactiva-e95ad.firebaseio.com/usuarios/$idUsuario.json';
    final resp = await http.put(url, body: '{"token":"$token"}');
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<int> borrarProducto(String idUsuario) async {
    final url =
        'https://radioactiva-e95ad.firebaseio.com/usuarios/$idUsuario.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }
}
