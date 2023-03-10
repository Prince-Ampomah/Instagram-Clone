import 'package:logger/logger.dart';

Logger logger = Logger();

class Const {
  // app bar icons
  static const String instragramLogoIcon = 'assets/icons/logo.png';
  static const String instragramAddIcon = 'assets/icons/more.png';
  static const String instragramChatIcon = 'assets/icons/chat.png';

  // bottom nav icons
  static const String instragramHomeIcon = 'assets/icons/home.png';
  static const String instragramReelIcon = 'assets/icons/video.png';
  static const String instragramShopIcon = 'assets/icons/bag.png';
  static const String instragramSearchIcon = 'assets/icons/search.png';

  // gallery post reaction icons
  static const String instragramSendIcon = 'assets/icons/send.png';
  static const String instragramVerifiedIcon = 'assets/icons/verified.png';
  static const String instragramCommentIcon = 'assets/icons/comment.png';
  static const String instragramSaveIcon = 'assets/icons/save.png';
  static const String instragramfavoriteIcon = 'assets/icons/favorite.png';

  // assets image path
  static const String userImage = 'assets/images/user.png';
  static const String princeImage = 'assets/images/prince.jpg';
  static const String reelImage = 'assets/images/reel_image.jpg';

  static const String loadingGif = 'assets/gif/spinner.gif';
  static const String loadingGif1 = 'assets/gif/loading.gif';

  // hive constants
  // hive type ids to avoid traversing through all model
  static const int hiveTypeId0 = 0; // used for user model
  static const int hiveTypeId1 = 1;
  static const int hiveTypeId2 = 2;
  static const int hiveTypeId3 = 3;
  static const String userBoxName = 'userBox';
  static const String currentUser = 'currentUser';

  // Firestore contants
  static const String usersCollection = 'users';
}
