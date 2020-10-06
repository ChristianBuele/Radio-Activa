import 'package:flutter/material.dart';
import 'package:radioactiva/src/pages/video_page.dart';
import 'package:video_player/video_player.dart';

class PlayPauseOverlay extends StatefulWidget {
  const PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  _PlayPauseOverlayState createState() => _PlayPauseOverlayState();
}

class _PlayPauseOverlayState extends State<PlayPauseOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            if (videoBloc.videoPlayerController.value.isPlaying) {
              widget.controller.pause();
              videoBloc.isPlaying = false;
            } else {
              widget.controller.play();
              videoBloc.isPlaying = true;
            }
            setState(() {});
          },
        ),
      ],
    );
  }
}
