import 'package:hive/hive.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.g.dart';

@HiveType(typeId: Const.hiveTypeId0)
class UserModel {
  @HiveField(0)
  String? userId;

  @HiveField(1)
  String? profileImage;

  @HiveField(2)
  String? fullname;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? phoneNumber;

  @HiveField(5)
  String? userHandle;

  @HiveField(6)
  DateTime? createdAt;

  UserModel({
    this.userId,
    this.profileImage,
    this.fullname,
    this.email,
    this.phoneNumber,
    this.userHandle,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['userId'] = userId;
    map['profileImage'] = profileImage;
    map['fullname'] = fullname;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['userHandle'] = userHandle;
    map['createdAt'] = createdAt;

    return map;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      profileImage: json['profileImage'],
      fullname: json['fullname'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      userHandle: json['userHandle'],
      createdAt: (json['createdAt'] is Timestamp)
          ? json['createdAt'].toDate()
          : json['createdAt'],
    );
  }
}
