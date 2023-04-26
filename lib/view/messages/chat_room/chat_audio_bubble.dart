import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:instagram_clone/model/chat_model/chat_model.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

import '../../../controller/audio_controller/audio_player_controller.dart';
import '../../../controller/chat_controller/chat_controller.dart';
import '../../../controller/models_controller/models_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/date_time_convertor.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/cus_cached_image.dart';
import '../../profile/users_profile/users_profile_view.dart';

class ChatAudioBubble extends StatefulWidget {
  const ChatAudioBubble({super.key, required this.chatModel});
  final ChatModel chatModel;

  @override
  State<ChatAudioBubble> createState() => _ChatAudioBubbleState();
}

class _ChatAudioBubbleState extends State<ChatAudioBubble> {
  final audioPlayer = AudioPlayerController();

  @override
  void initState() {
    super.initState();
    audioPlayer.initPlayer(const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    audioPlayer.disposePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMe =
        widget.chatModel.senderId == FirebaseAuth.instance.currentUser!.uid;

    return GestureDetector(
      onLongPress: () {
        Utils.customDialog(
          context,
          onPressed2: () {
            ChatController.instance
                .deleteChatMessage(widget.chatModel.messageId!);
            Navigator.pop(context);
          },
          title: 'Delete Message',
          text1: 'Cancel',
          text2: 'Delete',
        );
      },
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && widget.chatModel.receiverImage != null)
            GestureDetector(
              onTap: () {
                sendToPage(
                  context,
                  UsersProfileView(
                    userModel: ChatController.instance.receiverModel,
                    postModel: ModelController.instance.postModel,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomCachedImage(
                    height: 30,
                    width: 30,
                    imageUrl: widget.chatModel.receiverImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Flexible(
            child: Container(
              height: 70,
              margin: EdgeInsets.only(
                right: isMe ? 10.0 : 80.0,
                left: isMe ? 100.0 : 10.0,
                bottom: 10.0,
              ),
              padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
              decoration: BoxDecoration(
                color: isMe
                    ? AppColors.audioButtonColor1
                    : AppColors.audioButtonColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: StreamBuilder<PlaybackDisposition>(
                stream: audioPlayer.onProgress,
                builder: (context, snapshot) {
                  final duration = snapshot.hasData
                      ? snapshot.data!.duration
                      : Duration.zero;
                  final position = snapshot.hasData
                      ? snapshot.data!.position
                      : Duration.zero;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await audioPlayer.togglePlaying(
                            widget.chatModel.media!.first,
                            whenFinished: () => setState(() {}),
                          );
                          setState(() {});
                        },
                        child: Icon(
                          audioPlayer.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: isMe ? Colors.white : Colors.black,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                            thumbShape: (const RoundSliderThumbShape(
                              enabledThumbRadius: 5.0,
                              elevation: 0.0,
                            )),
                            thumbColor: isMe
                                ? AppColors.whiteColor
                                : AppColors.blackColor,
                            activeTrackColor: AppColors.blackColor,
                            inactiveTrackColor: isMe
                                ? AppColors.whiteColor
                                : const Color(0xFFC6C6C6),
                          ),
                          child: Slider(
                            min: 0.0,
                            max: duration.inSeconds.toDouble(),
                            value: position.inSeconds.toDouble(),
                            onChanged: (value) async {
                              final position = Duration(seconds: value.toInt());
                              await audioPlayer.seekPlay(position);
                            },
                          ),
                        ),
                      ),
                      Text(
                        DateTimeConvertor.formatAudioTime(duration - position),
                        style: TextStyle(
                          fontSize: 12,
                          color: isMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
