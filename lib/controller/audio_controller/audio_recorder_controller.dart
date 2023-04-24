import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorderController {
  FlutterSoundRecorder? _recorder;
  bool get isRecording => _recorder!.isRecording;
  Stream<RecordingDisposition>? get onProgress => _recorder!.onProgress;
  bool isRecorderReady = false;

  Future initRecorder() async {
    _recorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await _recorder!.openRecorder();

    isRecorderReady = true;

    _recorder!.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  void dispose() {
    if (!isRecorderReady) return;
    _recorder!.closeRecorder();
    isRecorderReady = false;
  }

  Future record() async {
    if (!isRecorderReady) return;
    await _recorder!
        .startRecorder(toFile: '${DateTime.now().millisecondsSinceEpoch}.aac');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    return await _recorder!.stopRecorder();
  }
}
