import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogIn {
  final FirebaseAuth auth = FirebaseAuth.instance;

  logIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null && await userNotExists(user!.uid)) {
        addUserToDatabase(
            uid: user.uid,
            displayName: user.displayName,
            email: user.email,
            emailVerified: user.emailVerified,
            photoUrl: user.photoURL);
        return result;
      } else {
        print('User Already Exists');
      }
    }
  }

  Future<bool> userNotExists(uid) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future addUserToDatabase({
    required String uid,
    required String? displayName,
    required String? email,
    required bool emailVerified,
    required String? photoUrl,
  }) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final jsonData = {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'emailVerified': emailVerified,
      'photoUrl': photoUrl,
      'bandLimitation': 3
    };

    await docUser.set(jsonData);
  }
}
