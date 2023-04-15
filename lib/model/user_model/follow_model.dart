class FollowUnfollowModel {
  String? id;
  List<dynamic>? followers;

  List<dynamic>? following;

  FollowUnfollowModel({
    this.id,
    this.followers = const [],
    this.following = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['followers'] = followers;
    map['following'] = following;
    return map;
  }

  factory FollowUnfollowModel.fromJson(Map<String, dynamic> json) {
    return FollowUnfollowModel(
      id: json['id'],
      followers: json['followers'],
      following: json['following'],
    );
  }
}
