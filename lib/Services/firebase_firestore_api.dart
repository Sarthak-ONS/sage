import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirebaseFireStoreProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirebaseFirestore get firebaseFirestore => _firebaseFirestore;

  Future checkifUserAlreadyExists(String uid) async {
    try {
      final res = await _firebaseFirestore.collection('Users').doc(uid).get();
      if (res.exists) return true;
      return false;
    } catch (e) {
      print("Eror from checkifUserAlreadyExists");
      print(e);
    }
    notifyListeners();
  }

  Future createProfile(uid, name, email, photourl) async {
    if (await checkifUserAlreadyExists(uid)) return;
    try {
      await _firebaseFirestore.collection('Users').doc(uid).set({
        "name": name,
        "email": email,
        "uid": uid,
        "photoUrl": photourl,
      });
    } catch (e) {
      print(e);
    }
    //
    notifyListeners();
  }
}
