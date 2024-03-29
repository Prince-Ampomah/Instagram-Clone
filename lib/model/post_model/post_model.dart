import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/core/constants/constants.dart';

import 'post_location_model.dart';

part 'post_model.g.dart';

@HiveType(typeId: Const.hiveTypeId1)
class PostModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? caption;

  @HiveField(2)
  List<dynamic> media;

  @HiveField(3)
  num? like;

  @HiveField(4)
  num? comment;

  @HiveField(6)
  PostLocationModel? location;

  @HiveField(7)
  DateTime? timePosted;

  @HiveField(8)
  List<dynamic>? isSavedBy;

  @HiveField(9)
  List<dynamic>? isLikedBy;

  @HiveField(10)
  String? userId;

  @HiveField(11)
  String? postType;

  PostModel({
    this.id,
    this.media = const [],
    this.userId,
    this.caption,
    this.like = 0,
    this.comment = 0,
    this.location,
    this.timePosted,
    this.postType,
    this.isSavedBy = const [],
    this.isLikedBy = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['userId'] = userId;
    map['caption'] = caption;
    map['media'] = media;
    map['like'] = like;
    map['comment'] = comment;
    map['location'] = location!.toJson();
    map['timePosted'] = timePosted;
    map['postType'] = postType;
    map['isSavedBy'] = isSavedBy;
    map['isLikedBy'] = isLikedBy;

    return map;
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      caption: json['caption'],
      media: json['media'],
      like: json['like'],
      comment: json['comment'],
      location: PostLocationModel.fromJson(json['location']),
      timePosted: (json['timePosted'] is Timestamp)
          ? json['timePosted'].toDate()
          : json['timePosted'],
      isSavedBy: json['isSavedBy'],
      isLikedBy: json['isLikedBy'],
      postType: json['postType'],
    );
  }
}
