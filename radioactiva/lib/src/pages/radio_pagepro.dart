import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radioactiva/src/provider/radioProvider.dart';
import 'package:radioactiva/src/provider/videoProider.dart';
import 'package:radioactiva/src/utils/colores.dart' as color;
import 'package:radioactiva/src/utils/preferencias.dart';

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

  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    VideoBloc videoBloc = new VideoBloc();
    try {
      videoBloc.pause();
      print('pause a bideo');
    } catch (e) {
      print('ni hay problema de video');
    }
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          /* decoration: BoxDecoration(
            color: Colors.blueAccent,
            gradient: RadialGradient(colors: [Colors.black, Colors.red]),
            image: DecorationImage(
              image: AssetImage('assets/fpd.jpg'),
              fit: BoxFit.cover,
            ),
          ),*/
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print('object');
                  },
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.50,
                    movementDuration: Duration(seconds: 1),
                    child: Container(
                      child: ListTile(
                        leading: Container(
                          //   backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                          child: IconButton(
                              color: prefs.colorSecundario
                                  ? color.appBarColorLight
                                  : color.appBarColorDark,
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
                          // foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    secondaryActions: <Widget>[
                      /* Slider(
                        activeColor: prefs.colorSecundario
                            ? color.appBarColorLight
                            : color.appBarColorDark,
                        inactiveColor: Color.fromRGBO(120, 120, 120, 1),
                        value: radioBloc.volumen,
                        onChanged: (value) {
                          radioBloc.setvolumen(value);
                          setState(() {});
                        },
                        max: 1,
                        min: 0,
                      ),*/
                      SlideAction(
                        closeOnTap: true,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.red[700],
                            inactiveTrackColor: Colors.red[100],
                            trackShape: RoundedRectSliderTrackShape(),
                            trackHeight: 4.0,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 12.0),
                            thumbColor: Colors.redAccent,
                            overlayColor: Colors.red.withAlpha(32),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 28.0),
                            tickMarkShape: RoundSliderTickMarkShape(),
                            activeTickMarkColor: Colors.red[700],
                            inactiveTickMarkColor: Colors.red[100],
                            valueIndicatorShape:
                                PaddleSliderValueIndicatorShape(),
                            valueIndicatorColor: Colors.redAccent,
                            valueIndicatorTextStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: Slider(
                            activeColor: prefs.colorSecundario
                                ? color.appBarColorLight
                                : color.appBarColorDark,
                            inactiveColor: Color.fromRGBO(120, 120, 120, 1),
                            value: radioBloc.volumen,
                            onChanged: (value) {
                              radioBloc.setvolumen(value);
                              setState(() {});
                            },
                            max: 1,
                            min: 0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                /*Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        IconButton(
                            color: prefs.colorSecundario
                                ? color.appBarColorLight
                                : color.appBarColorDark,
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
                          activeColor: prefs.colorSecundario
                              ? color.appBarColorLight
                              : color.appBarColorDark,
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
                    )),*/
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                  decoration: BoxDecoration(shape: BoxShape.circle,
                      // borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x30000000),
                            offset: Offset(0, 20),
                            spreadRadius: 0,
                            blurRadius: 20),
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                            blurRadius: 80),
                      ]),
                  child: imagenRadio(size),
                ),
                Text(
                  'Radio Activa',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text('¡ACTIVA TU MÚSICA!',
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                SizedBox(
                  height: 20,
                ),
                /*  StreamBuilder<String>(
                    initialData: "",
                    stream: radioBloc.radio.metaDataStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("los datos que llega son ${snapshot.data}");
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
                'https://res.cloudinary.com/dp3hnmhpg/image/upload/v1602635953/b14ppfosamwf1ssunakj.png')),
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
                  color: prefs.colorSecundario
                      ? color.appBarColorLight
                      : color.appBarColorDark,
                  size: 40,
                )
              : SpinKitWave(
                  color: prefs.colorSecundario
                      ? color.appBarColorLight
                      : color.appBarColorDark,
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
                  color: prefs.colorSecundario
                      ? color.appBarColorLight
                      : color.appBarColorDark,
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

                  backgroundColor: prefs.colorSecundario
                      ? color.appBarColorLight
                      : color.appBarColorDark,
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
                  color: prefs.colorSecundario
                      ? color.appBarColorLight
                      : color.appBarColorDark,
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
    super.dispose();
  }
}
