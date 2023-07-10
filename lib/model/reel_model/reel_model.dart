import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:instagram_clone/core/constants/constants.dart';

part 'reel_model.g.dart';

@HiveType(typeId: Const.hiveTypeId4)
class ReelModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? caption;

  @HiveField(2)
  String media;

  @HiveField(3)
  num? like;

  @HiveField(4)
  num? comment;

  // @HiveField(6)
  // PostLocationModel? location;

  @HiveField(7)
  DateTime? timePosted;

  @HiveField(8)
  List<dynamic>? isSavedBy;

  @HiveField(9)
  List<dynamic>? isLikedBy;

  @HiveField(10)
  String? userId;

  ReelModel({
    this.id,
    required this.media,
    this.userId,
    this.caption,
    this.like = 0,
    this.comment = 0,
    this.timePosted,
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
    map['timePosted'] = timePosted;
    map['isSavedBy'] = isSavedBy;
    map['isLikedBy'] = isLikedBy;

    return map;
  }

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'],
      userId: json['userId'],
      caption: json['caption'],
      media: json['media'],
      like: json['like'],
      comment: json['comment'],
      timePosted: (json['timePosted'] is Timestamp)
          ? json['timePosted'].toDate()
          : json['timePosted'],
      isSavedBy: json['isSavedBy'],
      isLikedBy: json['isLikedBy'],
    );
  }
}
