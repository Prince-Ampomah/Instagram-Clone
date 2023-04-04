import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: Image.asset(
        Const.instragramSendIcon,
        color: Colors.black,
      ),
    );
  }
}
