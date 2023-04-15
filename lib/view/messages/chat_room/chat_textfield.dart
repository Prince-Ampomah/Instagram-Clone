import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 5.0, 15, 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.buttonBgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
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
          const Flexible(
            child: TextField(
              // focusNode: widget.textFocus,
              // controller: widget.textCtrl,
              maxLines: 7,
              minLines: 1,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.newline,
              textAlign: TextAlign.justify,
              cursorColor: AppColors.blackColor,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: InputBorder.none,
                hintText: 'Message...',
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mic_none_outlined,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.image_outlined,
              size: 27,
            ),
          ),
        ],
      ),
    );
  }
}
