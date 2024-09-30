import 'package:audioplayers/audioplayers.dart';

class SomUtil {
  final AudioPlayer _player = AudioPlayer();

  SomUtil() {
    _player.setReleaseMode(ReleaseMode.stop);
  }

  play(String? source) async {
    if (source == null || source == "") {
      return;
    }
    await _player.play(AssetSource(source));
    // await _player.play();
  }

  pause() async {
    await _player.pause();
  }

  stop() async {
    await _player.stop();
  }
}
