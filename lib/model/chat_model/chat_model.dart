import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? id;
  String? chatId;
  String? message;
  String? messageType;
  String? senderId;
  String? receiverId;
  DateTime? timeSent;
  List<dynamic>? media = [];

  ChatModel({
    this.id,
    this.chatId,
    this.senderId,
    this.receiverId,
    this.message,
    this.messageType,
    this.media,
    this.timeSent,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['chatId'] = chatId;
    map['senderId'] = senderId;
    map['receiverId'] = receiverId;
    map['media'] = media;
    map['message'] = message;
    map['messageType'] = messageType;
    map['timeSent'] = timeSent;

    return map;
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      chatId: json['chatId'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      media: json['media'],
      message: json['message'],
      messageType: json['messageType'],
      timeSent: (json['timeSent'] is Timestamp)
          ? json['timeSent'].toDate()
          : json['timeSent'],
    );
  }
}
