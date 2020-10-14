import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }
  SharedPreferences _prefs;
  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  PreferenciasUsuario._internal();

  get genero {
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
  }

  get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? true;
  }

  set colorSecundario(bool value) {
    _prefs.setBool('colorSecundario', value);
  }

  set token(String token) {
    _prefs.setString('token', token);
  }

  get token {
    return _prefs.get('token') ?? 'no-token';
  }

  set idUsuario(String id) {
    _prefs.setString('idUsuario', id);
  }

  get idUsuario {
    return _prefs.get('idUsuario') ?? null;
  }

  set whatsapp(String mensaje) {
    _prefs.setString('whatsapp', mensaje);
  }

  get whatsapp {
    return _prefs.get('whatsapp') ?? 'Hola quiero mandar un saludo para ';
  }

  set mensaje(String mensaje) {
    _prefs.setString('mensaje', mensaje);
  }

  get mensaje {
    return _prefs.get('mensaje') ?? 'Quiero ...';
  }
}
