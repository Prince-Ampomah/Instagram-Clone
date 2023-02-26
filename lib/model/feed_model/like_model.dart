class LikeModel {
  num? likes;
  String? id;

  LikeModel({
    this.likes,
    this.id,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['likes'] = likes;

    return map;
  }

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id'],
      likes: json['likes'],
    );
  }
}
