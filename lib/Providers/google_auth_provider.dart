import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthpProvider extends ChangeNotifier {
  final googleSignin = GoogleSignIn();

  GoogleSignInAccount? _googleSignInAccount;

  GoogleSignInAccount get user => _googleSignInAccount!;

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
}
