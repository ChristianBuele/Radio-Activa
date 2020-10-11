import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radioactiva/src/provider/radioProvider.dart';
import 'package:radioactiva/src/utils/colores.dart' as color;

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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          gradient: RadialGradient(colors: [Colors.black, Colors.red]),
          image: DecorationImage(
            image: AssetImage('assets/fpd.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        width: size.width,
        child: Stack(children: [
          Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      IconButton(
                          color: Colors.white,
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
                        activeColor: color.appBarColorLight,
                        inactiveColor: Color.fromRGBO(120, 120, 120, 1),
                        value: radioBloc.volumen,
                        onChanged: (value) {
                          radioBloc.setvolumen(value);
                          setState(() {});
                        },
                        max: 1,
                        min: 0,
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
              /*  StreamBuilder<String>(
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
                ),*/
              reproductor(size),
            ],
          ),
        ]),
      ),
    );
  }

  Widget reproductor(size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StreamBuilder(
          stream: radioBloc.radio.isPlayingStream,
          builder: (context, AsyncSnapshot<String> snapshot) {
            String returnData = snapshot.data;
            switch (returnData) {
              case FlutterRadioPlayer.flutter_radio_stopped:
                return opciones(snapshot, size);
                break;
              case FlutterRadioPlayer.flutter_radio_loading:
                return Row(
                  children: [
                    /*Text(
                      'Cargando...     ',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 1),
                          ]),
                    ),*/
                    CircularProgressIndicator(
                      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                );
                break;
              case FlutterRadioPlayer.flutter_radio_error:
                return RaisedButton(
                    child: Text("Retry ?"),
                    onPressed: () async {
                      await radioBloc.initRadioService();
                    });
                break;
              default:
                return opciones(snapshot, size);
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

  Widget opciones(AsyncSnapshot<String> snapshot, size) {
    return Container(
      width: size.width * 0.7,
      child: Column(
        children: [
          (radioBloc.isPlaying)
              ? SpinKitRipple(
                  color: Colors.white,
                  size: 40,
                )
              : SpinKitWave(
                  color: Colors.white,
                  size: 40.0,
                ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  //para recargar la se;al
                  icon: Icon(FontAwesomeIcons.sync),
                  color: Colors.white,
                  splashColor: Colors.redAccent,
                  splashRadius: 30.0,
                  onPressed: () async {
                    await radioBloc.radio.stop();
                    await radioBloc.initRadioService();
                    radioBloc.isPlaying = false;

                    setState(() {});
                  }),
              FloatingActionButton(
                  //buton del play
                  //play

                  backgroundColor: color.appBarColorLight,
                  elevation: 13,
                  splashColor: Colors.yellow,
                  child:
                      snapshot.data == FlutterRadioPlayer.flutter_radio_playing
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow),
                  onPressed: () async {
                    print("button press data: " + snapshot.data.toString());
                    if (snapshot.data ==
                        FlutterRadioPlayer.flutter_radio_stopped) {
                      await radioBloc.initRadioService();
                    }

                    if (snapshot.data.toString() == "flutter_radio_playing") {
                      radioBloc.isPlaying = true;
                    } else {
                      radioBloc.isPlaying = false;
                    }
                    await radioBloc.radio.playOrPause();
                    setState(() {});
                  }),
              IconButton(
                  //boton del stop
                  icon: Icon(FontAwesomeIcons.stop),
                  splashColor: Colors.redAccent,
                  splashRadius: 30.0,
                  color: Colors.white,
                  onPressed: () async {
                    radioBloc.isPlaying = false;
                    await radioBloc.radio.stop();

                    setState(() {});
                  }),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
