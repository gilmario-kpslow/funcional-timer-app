import 'package:audioplayers/audioplayers.dart';
// import 'dart:async';

class SomUtil {
  AudioPlayer _player = AudioPlayer();

  init() async {
    _player.setReleaseMode(ReleaseMode.stop);
    await _player.setSource(AssetSource('audio/sino01.mp3'));
  }

  play() async {
    await _player.setSource(AssetSource('audio/sino01.mp3'));
    await _player.resume();
  }
}
