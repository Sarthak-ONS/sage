// ignore_for_file: file_names

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static var accesstoken = "";
  static var idToken = "";

  Future login() async {
    _googleSignIn.signOut();
    return;
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    GoogleSignInAuthentication auth = await account!.authentication;
    return account;
  }
}
