import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/core/constants/constants.dart';

import '../user_model/user_model.dart';
import 'post_location_model.dart';

part 'post_model.g.dart';

@HiveType(typeId: Const.hiveTypeId1)
class PostModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? caption;

  @HiveField(2)
  List<dynamic>? media;

  @HiveField(3)
  num? like;

  @HiveField(4)
  num? comment;

  @HiveField(5)
  UserModel? userModel;

  @HiveField(6)
  PostLocationModel? location;

  @HiveField(7)
  DateTime? timePosted;

  @HiveField(8)
  bool? isSaved;

  PostModel({
    this.id,
    this.media,
    this.userModel,
    this.caption,
    this.like = 0,
    this.comment = 0,
    this.location,
    this.timePosted,
    this.isSaved = false,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['caption'] = caption;
    map['media'] = media;
    map['user'] = userModel!.toJson();
    map['like'] = like;
    map['comment'] = comment;
    map['location'] = location!.toJson();
    map['timePosted'] = timePosted;
    map['isSaved'] = isSaved;

    return map;
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      caption: json['caption'],
      media: json['media'],
      like: json['likes'],
      comment: json['comment'],
      userModel: UserModel.fromJson(json['user']),
      location: PostLocationModel.fromJson(json['location']),
      timePosted: (json['timePosted'] is Timestamp)
          ? json['timePosted'].toDate()
          : json['timePosted'],
      isSaved: json['isSaved'],
    );
  }
}
