import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radioactiva/src/provider/radioProvider.dart';

class RadioPageLight extends StatefulWidget {
  @override
  _RadioPageLightState createState() => _RadioPageLightState();
}

class _RadioPageLightState extends State<RadioPageLight> {
  RadioBloc radioBloc;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    radioBloc = new RadioBloc();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Stack(children: [
            Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon((radioBloc.volumen == 0)
                                ? (FontAwesomeIcons.volumeMute)
                                : FontAwesomeIcons.volumeUp),
                            onPressed: () {
                              if (radioBloc.volumen != 0) {
                                radioBloc.setvolumen(0.0);
                              } else {
                                radioBloc.setvolumen(0.8);
                              }
                              setState(() {});
                            }),
                        Slider(
                          value: radioBloc.volumen,
                          onChanged: (value) {
                            radioBloc.setvolumen(value);
                            setState(() {});
                          },
                          max: 1,
                          min: 0,
                        ),
                        SizedBox(
                          width: 130,
                        ),
                        Icon(
                          radioBloc.isPlaying
                              ? FontAwesomeIcons.sadCry
                              : FontAwesomeIcons.smileBeam,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x99000000),
                            offset: Offset(0, 20),
                            spreadRadius: 0,
                            blurRadius: 20),
                        BoxShadow(
                            color: Color(0x55000000),
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                            blurRadius: 80),
                      ]),
                  child: imagenRadio(size),
                ),
                /*
                Text(
                  'Radio Activa',
                  style: TextStyle(fontSize: 20),
                ),
                Text('Chicha Radio Activa'),
                SizedBox(
                  height: 20,
                ),*/
                StreamBuilder<String>(
                    initialData: "",
                    stream: radioBloc.radio.metaDataStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Radio Activa',
                          style: TextStyle(fontSize: 20),
                        );
                      }
                      return Text(snapshot.data);
                    }),
                SizedBox(
                  height: 40,
                ),
                reproductor(),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget reproductor() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StreamBuilder(
          stream: radioBloc.radio.isPlayingStream,
          builder: (context, AsyncSnapshot<String> snapshot) {
            String returnData = snapshot.data;
            switch (returnData) {
              case FlutterRadioPlayer.flutter_radio_stopped:
                return opciones(snapshot);
                break;
              case FlutterRadioPlayer.flutter_radio_loading:
                return CircularProgressIndicator();
                break;
              case FlutterRadioPlayer.flutter_radio_error:
                return RaisedButton(
                    child: Text("Retry ?"),
                    onPressed: () async {
                      await radioBloc.initRadioService();
                    });
                break;
              default:
                return opciones(snapshot);
            }
          },
        )
        /*IconButton(icon: Icon(Icons.replay_outlined), onPressed: () {}),
        IconButton(
            iconSize: 40, icon: Icon(FontAwesomeIcons.play), onPressed: () {}),
        IconButton(icon: Icon(Icons.stop), onPressed: () {}),*/
      ],
    );
  }

  Widget imagenRadio(size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: GestureDetector(
        child: FadeInImage(
            width: size.width * 0.7,
            height: size.width * 0.7,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(
                'https://res.cloudinary.com/dp3hnmhpg/image/upload/v1602116388/ewddftgfhii5e51e6pvr.jpg')),
        onTap: () {
          print('Toca la imagen');
        },
      ),
    );
  }

  Widget opciones(AsyncSnapshot<String> snapshot) {
    return Container(
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.replay_outlined),
              onPressed: () async {
                await radioBloc.radio.stop();
                await radioBloc.initRadioService();
              }),
          FloatingActionButton(
              //play
              focusColor: Colors.yellowAccent,
              backgroundColor: Colors.red[300],
              splashColor: Colors.yellow,
              child: snapshot.data == FlutterRadioPlayer.flutter_radio_playing
                  ? Icon(Icons.pause)
                  : Icon(Icons.play_arrow),
              onPressed: () async {
                print("button press data: " + snapshot.data.toString());
                if (snapshot.data == FlutterRadioPlayer.flutter_radio_stopped) {
                  await radioBloc.initRadioService();
                }

                if (snapshot.data.toString() == "flutter_radio_playing") {
                  print('giaues');
                  radioBloc.isPlaying = true;
                } else {
                  radioBloc.isPlaying = false;
                }
                await radioBloc.radio.playOrPause();
                setState(() {});
              }),
          IconButton(
              icon: Icon(Icons.stop),
              onPressed: () async {
                await radioBloc.radio.stop();
              }),
        ],
      ),
    );
  }
}
