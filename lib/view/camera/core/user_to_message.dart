import 'package:flutter/material.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/widgets/cus_rich_text.dart';

class UserToMessage extends StatelessWidget {
  const UserToMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 40,
        width: size.width,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
        ),
        child: CustomRichText(
          text1: 'Message ',
          text2: ChatController.instance.receiverModel?.fullname ?? '',
          text1Style: const TextStyle(color: Colors.white),
          text2Style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
