class LikeModel {
  num? numberOflikes;
  String? id;
  String? userId;
  String? postId;

  LikeModel({
    this.numberOflikes,
    this.id,
    this.postId,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map['id'] = id;
    map['postId'] = postId;
    map['userId'] = userId;
    map['numberOflikes'] = numberOflikes;

    return map;
  }

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id'],
      postId: json['postId'],
      userId: json['userId'],
      numberOflikes: json['numberOflikes'],
    );
  }
}
