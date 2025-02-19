import 'package:audioplayers/audioplayers.dart';

class SomUtil {
  final AudioPlayer _player = AudioPlayer();

  SomUtil() {
    AudioPlayer.global.setAudioContext(AudioContextConfig(
            stayAwake: true, focus: AudioContextConfigFocus.mixWithOthers)
        .build());
    _player.setReleaseMode(ReleaseMode.stop);
    _player.setPlayerMode(PlayerMode.lowLatency);
  }

  play(String? source) async {
    if (source == null || source == "") {
      return;
    }
    await _player.play(AssetSource(source));
  }

  pause() async {
    await _player.pause();
  }

  stop() async {
    await _player.stop();
  }
}
