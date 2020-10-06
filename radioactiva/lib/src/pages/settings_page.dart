import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_radio/flutter_radio.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String url = "https://radio.kapchosting.com/9308/stream";

  bool isPlaying = false;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey.shade900,
        child: new Column(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Icon(
                Icons.radio,
                size: 250,
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Align(
                  alignment: FractionalOffset.center,
                  child: IconButton(
                    icon: isPlaying
                        ? Icon(
                            Icons.pause_circle_outline,
                            size: 80,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                            size: 80,
                          ),
                    onPressed: () {
                      print('play');
                      setState(() {
                        FlutterRadio.play(url: url);
                        isPlaying = !isPlaying;
                        isVisible = !isVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
  }

  @override
  void initState() {
    super.initState();
    audioStart();
  }
}
