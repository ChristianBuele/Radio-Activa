import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';

class RadioBloc {
  static final RadioBloc _singleton = new RadioBloc._internal();
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();
  bool isPlaying = false;
  double volumen = 0.8;
  factory RadioBloc() {
    return _singleton;
  }
  RadioBloc._internal() {
    obtenerRadio();
  }

  void obtenerRadio() {
    initRadioService();
  }

  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init("Radio Activa", "Live",
          "https://radio.kapchosting.com/9308/stream", "false");
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }

  FlutterRadioPlayer get radio {
    return _flutterRadioPlayer;
  }
}
