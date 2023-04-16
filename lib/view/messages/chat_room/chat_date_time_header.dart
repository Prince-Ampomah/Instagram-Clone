import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/date_time_convertor.dart';

class ChatDateAndTimeHeader extends StatelessWidget {
  const ChatDateAndTimeHeader({
    super.key,
    required this.snapshot,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          DateTimeConvertor.calcuateTimeDiffernce(
            snapshot.data()[Const.timeSent]?.toDate() ?? DateTime.now(),
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
