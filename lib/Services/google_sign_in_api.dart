import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sage/Providers/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInApi {
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  Future login(context) async {
    GoogleSignInAccount? account = await googleSignIn.signIn();
    GoogleSignInAuthentication auth = await account!.authentication;

    Provider.of<UserData>(context, listen: false).changeUserDetails(
      account.displayName,
      account.photoUrl,
      account.email,
      account.id,
      "",
      "",
    );

    return account;
  }

  Future logout() async {
    try {
      googleSignIn.signOut();
      return true;
    } catch (e) {
      return null;
    }
  }
}
