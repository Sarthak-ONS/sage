import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthpProvider extends ChangeNotifier {
  final googleSignin = GoogleSignIn();

  GoogleSignInAccount? _googleSignInAccount;

  GoogleSignInAccount get user => _googleSignInAccount!;

  String? name;
  String? uid;
  String? email;
  String? photoUrl;

  Future signInwithGoogle() async {
    try {
      final googleUserTemp = await googleSignin.signIn();
      if (googleUserTemp == null) return;

      _googleSignInAccount = googleUserTemp;

      final googleAuthAcc = await googleUserTemp.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuthAcc.accessToken,
        idToken: googleAuthAcc.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("error From Google Auth Provider Method");
      print(e);
    }
    notifyListeners();
  }

  Future logout() async {
    FirebaseAuth.instance.signOut();
    googleSignin.disconnect();
  }

  Future changeCurrentUserDetails({email, uid, photoUrl, name}) async {
    try {
      this.email = email;
      this.uid = uid;
      this.photoUrl = photoUrl;
      this.name = name;
      notifyListeners();
    } catch (e) {
      print("Error Receiving From ChangeCurrentUserDetails");
      print(e);
    }
  }
}
