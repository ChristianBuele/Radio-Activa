import 'package:video_player/video_player.dart';

class VideoBloc {
  static final _singleton = new VideoBloc._internal();
  VideoPlayerController videoPlayerController;
  int tiempoVideo = 0;
  int tiempoAver = 0;
  double volumen = 0.8;
  bool isPlaying = false;
  factory VideoBloc() {
    return _singleton;
  }
  VideoBloc._internal() {
    obtenerRadio();
  }
  void initRadioService() async {
    videoPlayerController = VideoPlayerController.network(
        'https://srv4.zcast.com.br/freddy2571/freddy2571/playlist.m3u8');
    await videoPlayerController.initialize();
    videoPlayerController.addListener(() {
      tiempoVideo = videoPlayerController.value.position.inSeconds;
    });
  }

  void obtenerRadio() {
    initRadioService();
  }

  void pause() {
    isPlaying = false;
    this.videoPlayerController.pause();
  }

  void play() {
    isPlaying = true;
    this.videoPlayerController.play();
  }

  void stop() {
    isPlaying = false;
  }

  void setVolumen(double volume) {
    volumen = volume;
    videoPlayerController.setVolume(volume);
  }

  void mover(int seconds) {
    int x = tiempoVideo - seconds;
    if (x > 0) {
      videoPlayerController.seekTo(Duration(seconds: seconds));
    }
  }
}
