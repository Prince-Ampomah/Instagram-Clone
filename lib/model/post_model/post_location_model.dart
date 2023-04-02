import 'package:hive/hive.dart';

import '../../core/constants/constants.dart';
part 'post_location_model.g.dart';

@HiveType(typeId: Const.hiveTypeId2)
class PostLocationModel {
  @HiveField(0)
  String? address;

  @HiveField(1)
  num? lat;

  @HiveField(2)
  num? lng;

  PostLocationModel({this.address, this.lat, this.lng});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['address'] = address;
    map['lat'] = lat;
    map['lng'] = lng;

    return map;
  }

  factory PostLocationModel.fromJson(Map<String, dynamic> json) {
    return PostLocationModel(
      address: json['address'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
