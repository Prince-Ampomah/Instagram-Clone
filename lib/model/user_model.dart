class UserModel {
  final String? userId;
  final String? profileImage;
  final String? fullname;
  final String? email;
  final String? phoneNumber;
  final String? userHandle;
  final String? userBirthday;

  UserModel({
    this.userId,
    this.profileImage,
    this.fullname,
    this.email,
    this.phoneNumber,
    this.userHandle,
    this.userBirthday,
  }) : assert(userId != null);
}
