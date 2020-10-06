import 'package:flutter/material.dart';
import 'package:radioactiva/src/models/reproVideo.dart';
import 'package:radioactiva/src/provider/radioProvider.dart';
import 'package:radioactiva/src/provider/videoProider.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

RadioBloc radioBloc = new RadioBloc();
VideoBloc videoBloc = new VideoBloc();

class _VideoPageState extends State<VideoPage> {
  double tiempoVideo = 0.0;
  @override
  Widget build(BuildContext context) {
    print('radio es $radioBloc');
    statusRadio();
    return Scaffold(
      backgroundColor: (videoBloc.videoPlayerController.value.isPlaying)
          ? Colors.black
          : Colors.white,
      body: videoBloc.videoPlayerController.value.initialized
          ? player(context)
          : CircularProgressIndicator(),
    );
  }

  statusRadio() async {
    final isPlaying = await radioBloc.radio.isPlaying();
    if (isPlaying) {
      radioBloc.radio.playOrPause();
      setState(() {});
    } else {
      print('siga nomas que no hay musica');
    }
  }

  player(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: videoBloc.videoPlayerController.value.aspectRatio,
          //child: VideoPlayer(videoBloc.videoPlayerController),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayer(videoBloc.videoPlayerController),
              controlesVideo(),
              VideoProgressIndicator(
                videoBloc.videoPlayerController,
                allowScrubbing: true,
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
                icon: videoBloc.videoPlayerController.value.isPlaying
                    ? Icon(
                        Icons.pause,
                        color: Colors.white,
                      )
                    : Icon(Icons.play_arrow),
                onPressed: () {
                  if (videoBloc.videoPlayerController.value.isPlaying) {
                    videoBloc.pause();
                  } else {
                    videoBloc.play();
                  }
                  setState(() {});
                }),
            IconButton(
                icon: Icon(
                  (videoBloc.volumen != 0)
                      ? Icons.volume_up
                      : Icons.volume_mute,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (videoBloc.volumen != 0) {
                      videoBloc.setVolumen(0.0);
                    } else {
                      videoBloc.setVolumen(0.5);
                    }
                  });
                }),
            Slider(
              value: videoBloc.volumen,
              onChanged: (value) {
                setState(() {
                  videoBloc.setVolumen(value);
                });
              },
              min: 0,
              max: 1,
            ),
            IconButton(
                icon: videoBloc.videoPlayerController.value.isPlaying
                    ? Icon(
                        Icons.replay,
                        color: Colors.white,
                      )
                    : Icon(Icons.replay_rounded),
                onPressed: () {
                  print('refrescando video');
                }),
            IconButton(
              //alignment: Alignment(24, 0.0),
              icon: Icon(
                Icons.fullscreen,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoBloc.isPlaying = false;
    setState(() {});
    videoBloc.videoPlayerController.dispose();
  }

  controlesVideo() {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: videoBloc.isPlaying
              ? SizedBox.shrink()
              : Container(
                  //color: Colors.black,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            if (videoBloc.videoPlayerController.value.isPlaying) {
              videoBloc.pause();
            } else {
              videoBloc.play();
            }
            setState(() {});
          },
        )
      ],
    );
  }
}
