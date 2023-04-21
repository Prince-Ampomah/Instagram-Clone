import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? messageId;
  String? chatId;
  String? message;
  String? messageType;
  String? senderId;
  String? receiverId;
  String? receiverImage;
  DateTime? timeSent;
  List<dynamic>? media;

  ChatModel({
    this.messageId,
    this.chatId,
    this.senderId,
    this.receiverId,
    this.receiverImage,
    this.message,
    this.messageType,
    this.media,
    this.timeSent,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['messageId'] = messageId;
    map['chatId'] = chatId;
    map['senderId'] = senderId;
    map['receiverId'] = receiverId;
    map['receiverImage'] = receiverImage;
    map['media'] = media;
    map['message'] = message;
    map['messageType'] = messageType;
    map['timeSent'] = timeSent;

    return map;
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      messageId: json['messageId'],
      chatId: json['chatId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      receiverImage: json['receiverImage'],
      media: json['media'],
      message: json['message'],
      messageType: json['messageType'],
      timeSent: (json['timeSent'] is Timestamp)
          ? json['timeSent'].toDate()
          : json['timeSent'],
    );
  }
}
