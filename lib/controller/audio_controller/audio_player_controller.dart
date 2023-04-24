import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class AudioPlayerController {
  FlutterSoundPlayer? _audioPlayer;
  bool get isPlaying => _audioPlayer!.isPlaying;
  Stream<PlaybackDisposition>? get onProgress => _audioPlayer!.onProgress;

  Future initPlayer(Duration duration) async {
    _audioPlayer = FlutterSoundPlayer();
    await _audioPlayer!.openPlayer();
    await _audioPlayer!.setSubscriptionDuration(duration);
  }

  Future disposePlayer() async {
    await _audioPlayer!.closePlayer();
  }

  Future _startPlaying(String audioPath, VoidCallback? whenFinished) async {
    await _audioPlayer!
        .startPlayer(fromURI: audioPath, whenFinished: whenFinished);
  }

  Future togglePlaying(String audioPath, {VoidCallback? whenFinished}) async {
    if (_audioPlayer!.isPlaying) {
      await _audioPlayer!.pausePlayer();
    } else if (_audioPlayer!.isPaused) {
      await _audioPlayer!.resumePlayer();
    } else if (_audioPlayer!.isStopped) {
      await _startPlaying(audioPath, whenFinished);
    } else {
      await _audioPlayer!.stopPlayer();
    }
  }

  Future seekPlay(Duration duration) async {
    if (_audioPlayer!.isPlaying) {
      await _audioPlayer!.seekToPlayer(duration);
    }
  }
}
