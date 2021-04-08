import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:http/http.dart' as http;
import 'package:radioactiva/src/utils/preferencias.dart';

class RadioBloc {
  static final RadioBloc _singleton = new RadioBloc._internal();
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();
  String radioUrl = '';
  double volumen = 0.8;
  final prefs = PreferenciasUsuario();
  StreamController _volumenController = StreamController<double>.broadcast();
  factory RadioBloc() {
    return _singleton;
  }
  RadioBloc._internal() {
    iniciarRadio();
  }
  void dispose() {
    _volumenController.close();
  }

  Stream<double> get streamVol => _volumenController.stream;
  Function(double) get streamVolumen => _volumenController.sink.add;

  Future<void> initRadioService() async {
    try {
      final res = await http
          .get('https://radioactiva-e95ad.firebaseio.com/enlaces.json');

      final decodedData = json.decode(res.body);
      this.radioUrl = decodedData['radio'];
      await iniciarRadio();
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }

  FlutterRadioPlayer get radio {
    return _flutterRadioPlayer;
  }

  void iniciarRadio() async {
    if (radioUrl == '') {
      radioUrl = 'https://radio.kapchosting.com/9308/stream';
    }
    print('la url de la radio es: ' + this.radioUrl);
    await this
        ._flutterRadioPlayer
        .init("Radio Activa", "Live", this.radioUrl, "false");
    this.streamVolumen(1);
  }

  void setvolumen(double vol) {
    this.volumen = vol;
    this.streamVolumen(vol);
    _flutterRadioPlayer.setVolume(volumen);
  }

  void detenerRadio() {
    this._flutterRadioPlayer.stop();
  }

  void playOrPause() {
    this._flutterRadioPlayer.playOrPause();
  }

  void play() {
    print('Play a la radio');
    this._flutterRadioPlayer.play();
  }

  void pause() {
    print('Pause a la radio');
    this._flutterRadioPlayer.pause();
  }
}
