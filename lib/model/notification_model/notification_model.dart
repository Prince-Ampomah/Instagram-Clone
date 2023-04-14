import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String? id;
  final String? userId;
  final String? userImage;
  final String? userHandle;
  final String? userFullName;
  final DateTime? date;

  NotificationModel({
    this.id,
    this.userId,
    this.userImage,
    this.userHandle,
    this.userFullName,
    this.date,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['userId'] = userId;
    map['userImage'] = userImage;
    map['userHandle'] = userHandle;
    map['userFullName'] = userFullName;
    map['date'] = date;

    return map;
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['userId'],
      userImage: json['userImage'],
      userHandle: json['userHandle'],
      userFullName: json['userFullName'],
      date: (json['date'] is Timestamp) ? json['date'].toDate() : json['date'],
    );
  }
}
