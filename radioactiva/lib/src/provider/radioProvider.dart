import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:http/http.dart' as http;

class RadioBloc {
  static final RadioBloc _singleton = new RadioBloc._internal();
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();
  AudioPlayer audioPlayer = new AudioPlayer();
  bool isPlaying = false;
  double volumen = 0.8;
  Duration duracion = new Duration();
  Duration posicion = new Duration();
  factory RadioBloc() {
    return _singleton;
  }
  RadioBloc._internal() {
    obtenerRadio();
  }
  void setvolumen(double vol) {
    this.volumen = vol;
    _flutterRadioPlayer.setVolume(volumen);
  }

  void obtenerRadio() {
    initRadioService();
  }

  Future<void> initRadioService() async {
    try {
      final res = await http
          .get('https://radioactiva-e95ad.firebaseio.com/enlaces.json');
      final decodedData = json.decode(res.body);
      final link = decodedData['radio'];
      await _flutterRadioPlayer.init("Radio Activa", "Live", link, "false");
      isPlaying = false;
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }

  FlutterRadioPlayer get radio {
    return _flutterRadioPlayer;
  }

  void actualizar() async {
    await _flutterRadioPlayer.stop();
    await _flutterRadioPlayer.play();
  }
}
