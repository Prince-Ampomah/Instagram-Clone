import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

import '../../controller/audio_controller/audio_recorder_controller.dart';
import '../theme/app_colors.dart';

class CustomAudioRecorder extends StatelessWidget {
  const CustomAudioRecorder({
    super.key,
    required this.audioRecorder,
    required this.stopRecording,
    required this.sendRecording,
  });

  /// Controller the manages the recording process
  final AudioRecorderController audioRecorder;

  /// Callback that is called when the recording stops
  final VoidCallback stopRecording;

  /// Callback that is called when the recording sent
  final VoidCallback sendRecording;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<RecordingDisposition>(
      stream: audioRecorder.onProgress,
      builder: (context, snapshot) {
        final duration =
            snapshot.hasData ? snapshot.data!.duration : Duration.zero;

        String twoDigits(int n) => n.toString().padLeft(2, '0');

        final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
        final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

        return Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 2,
            vertical: 4,
          ),
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 20),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: stopRecording,
                child: Container(
                  height: 35,
                  width: 35,
                  margin: const EdgeInsets.fromLTRB(10, 5, 0, 3),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              Text(
                '$twoDigitMinutes:$twoDigitSeconds',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: sendRecording,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 10, 3),
                  child: Icon(
                    Icons.north_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
