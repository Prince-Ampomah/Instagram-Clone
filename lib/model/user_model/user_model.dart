import 'package:hive/hive.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.g.dart';

@HiveType(typeId: Const.hiveTypeId0)
class UserModel extends HiveObject {
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

  @HiveField(7)
  String? bio;

  @HiveField(8)
  bool? isEmailVerified;

  @HiveField(9)
  num numberOfFollowers;

  @HiveField(10)
  num numberOfFollowing;

  @HiveField(11)
  num numberOfPost;

  @HiveField(12)
  List<dynamic>? listOfFollowers;

  @HiveField(13)
  List<dynamic>? listOfFollowing;

  UserModel({
    this.userId,
    this.profileImage,
    this.fullname,
    this.email,
    this.phoneNumber,
    this.userHandle,
    this.createdAt,
    this.isEmailVerified = false,
    this.bio,
    this.numberOfPost = 0,
    this.numberOfFollowers = 0,
    this.numberOfFollowing = 0,
    this.listOfFollowers = const [],
    this.listOfFollowing = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['userId'] = userId;
    map['profileImage'] = profileImage;
    map['fullname'] = fullname;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['userHandle'] = userHandle;
    map['isEmailVerified'] = isEmailVerified;
    map['createdAt'] = createdAt;
    map['bio'] = bio;
    map['numberOfPost'] = numberOfPost;
    map['numberOfFollowers'] = numberOfFollowers;
    map['numberOfFollowing'] = numberOfFollowing;
    map['listOfFollowers'] = listOfFollowers;
    map['listOfFollowing'] = listOfFollowing;

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
      isEmailVerified: json['isEmailVerified'],
      bio: json['bio'],
      numberOfPost: json['numberOfPost'],
      numberOfFollowers: json['numberOfFollowers'],
      numberOfFollowing: json['numberOfFollowing'],
      listOfFollowers: json['listOfFollowers'],
      listOfFollowing: json['listOfFollowing'],
      createdAt: (json['createdAt'] is Timestamp)
          ? json['createdAt'].toDate()
          : json['createdAt'],
    );
  }
}
