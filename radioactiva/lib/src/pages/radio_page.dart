import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:radioactiva/src/provider/radioProvider.dart';
import 'package:radioactiva/src/provider/videoProider.dart';

// ignore: must_be_immutable
class RadioPage extends StatefulWidget {
  var playerState = FlutterRadioPlayer.flutter_radio_paused;

  var volume = 0.8;
  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  RadioBloc radioBloc;
  @override
  void initState() {
    super.initState();
    radioBloc = new RadioBloc();
  }

  @override
  Widget build(BuildContext context) {
    estadoTv();
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            StreamBuilder(
                stream: radioBloc.radio.isPlayingStream,
                initialData: widget.playerState,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  String returnData = snapshot.data;
                  print("object data: " + returnData);
                  switch (returnData) {
                    case FlutterRadioPlayer.flutter_radio_stopped:
                      return RaisedButton(
                          child: Text("Start listening now"),
                          onPressed: () async {
                            await radioBloc.initRadioService();
                            // await radioBloc.radio.play();
                          });
                      break;
                    case FlutterRadioPlayer.flutter_radio_loading:
                      return CircularProgressIndicator();
                    case FlutterRadioPlayer.flutter_radio_error:
                      return RaisedButton(
                          child: Text("Retry ?"),
                          onPressed: () async {
                            await radioBloc.initRadioService();
                          });
                      break;
                    default:
                      return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                onPressed: () async {
                                  print("button press data: " +
                                      snapshot.data.toString());
                                  if (snapshot.data.toString() ==
                                      "flutter_radio_playing") {
                                    print('giaues');
                                    radioBloc.isPlaying = true;
                                  } else {
                                    radioBloc.isPlaying = false;
                                  }
                                  await radioBloc.radio.playOrPause();
                                },
                                icon: snapshot.data ==
                                        FlutterRadioPlayer.flutter_radio_playing
                                    ? Icon(Icons.pause)
                                    : Icon(Icons.play_arrow)),
                            IconButton(
                                onPressed: () async {
                                  await radioBloc.radio.stop();
                                  radioBloc.isPlaying = false;
                                },
                                icon: Icon(Icons.stop))
                          ]);
                      break;
                  }
                }),
            Slider(
                value: radioBloc.volumen,
                min: 0,
                max: 1.0,
                onChanged: (value) => setState(() {
                      radioBloc.volumen = value;
                      radioBloc.radio.setVolume(value);
                    })),
            SizedBox(
              height: 15,
            ),
            StreamBuilder<dynamic>(
                initialData: 'CircularProgressIndicator()',
                stream: radioBloc.radio.metaDataStream,
                builder: (context, snapshot) {
                  return Text(snapshot.data);
                }),
          ],
        ),
      ),
    );
  }

  void estadoTv() {
    VideoBloc videoBloc = new VideoBloc();
    if (videoBloc.videoPlayerController.value.isPlaying) {
      videoBloc.pause();
      radioBloc.actualizar();
    }
  }
}
