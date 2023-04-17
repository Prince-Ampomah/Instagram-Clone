import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';

class RecentChatModel {
  String? messageId;
  String? recentMessage;
  String? senderId;
  String? receiverId;
  UserModel? receiverModel;
  DateTime? timeSent;
  List<dynamic>? media = [];

  RecentChatModel({
    this.messageId,
    this.senderId,
    this.receiverId,
    this.receiverModel,
    this.recentMessage, // will use it for images 📷 Photo
    this.media,
    this.timeSent,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['messageId'] = messageId;
    map['senderId'] = senderId;
    map['receiverId'] = receiverId;
    map['receiverModel'] = receiverModel!.toJson();
    map['recentMessage'] = recentMessage;
    map['timeSent'] = timeSent;

    return map;
  }

  factory RecentChatModel.fromJson(Map<String, dynamic> json) {
    return RecentChatModel(
      messageId: json['messageId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      // receiverImage: json['receiverImage'],
      // receiverName: json['receiverName'],
      recentMessage: json['recentMessage'],
      receiverModel: UserModel.fromJson(json['receiverModel'] ?? {}),
      timeSent: (json['timeSent'] is Timestamp)
          ? json['timeSent'].toDate()
          : json['timeSent'],
    );
  }
}
