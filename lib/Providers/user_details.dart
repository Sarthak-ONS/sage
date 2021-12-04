import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier {
  String? currentUserName;
  String? currentUserEmail;
  String? userPhotoUrl;
  String? uID;
  String? userIDToken;
  String? userAccessToken;
  changeUserDetails(String? name, String? url, String? email, String? userID,
      String idtoken, String accessToken) {
    currentUserName = name;
    currentUserEmail = email;
    userPhotoUrl = url;
    uID = userID;
    userIDToken = idtoken;
    userAccessToken = accessToken;

    notifyListeners();
  }
}
