import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/camera/camera_view.dart';
import 'package:instagram_clone/view/messages/chat_room/pick_images_option.dart';

import '../../../controller/audio_controller/audio_recorder_controller.dart';
import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_audio_recorder.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({
    super.key,
  });

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  // instantiate audio recorder object
  final audioRecorder = AudioRecorderController();

  @override
  void initState() {
    super.initState();
    audioRecorder.initRecorder();
    ChatController.instance.addListenerToChatTextField();
  }

  @override
  void dispose() {
    audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!audioRecorder.isRecording) {
      return Container(
        margin: const EdgeInsets.fromLTRB(5, 5.0, 5, 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.buttonBgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                sendToPage(context, const CameraView());
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Flexible(
              child: TextField(
                focusNode: ChatController.chatTextFieldFocus,
                controller: ChatController.chatTextController,
                maxLines: 7,
                minLines: 1,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.newline,
                textAlign: TextAlign.justify,
                cursorColor: AppColors.blackColor,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: InputBorder.none,
                  hintText: 'Message...',
                ),
              ),
            ),
            GetBuilder<ChatController>(
              builder: (chatController) {
                if (chatController.isTyping &&
                    ChatController.chatTextController.text.trim().isNotEmpty) {
                  return GestureDetector(
                    onTap: chatController.sendTextMessage,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(5, 8, 15, 8),
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: AppColors.chatColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (audioRecorder.isRecording) {
                            await audioRecorder.stop();
                          } else {
                            await audioRecorder.record();
                          }

                          setState(() {});
                        },
                        child: const Icon(
                          Icons.mic_none_outlined,
                          size: 27,
                        ),
                      ),
                      8.pw,
                      GestureDetector(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return PickImagesOption(
                                chatController: chatController,
                              );
                            },
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.image_outlined,
                            size: 27,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      );
    } else {
      return CustomAudioRecorder(
        audioRecorder: audioRecorder,
        sendRecording: () async {
          String audioFile = await audioRecorder.stop();
          ChatController.instance.chatMedia!.clear();
          ChatController.instance.chatMedia = [audioFile];
          ChatController.instance.sendMediaMessage(Const.audioType);
          setState(() {});
        },
        stopRecording: () async {
          await audioRecorder.stop();
          setState(() {});
        },
      );
    }
  }
}
