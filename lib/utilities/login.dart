import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kabanda_app/screens/homeScreen.dart';
import 'package:kabanda_app/screens/loginScreen.dart';

class AuthService {
  handleAuthService() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot);
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        });
  }

  signInWithGoogle() async {
    // final GoogleSignInAccount? googleUser =
    //     await GoogleSignIn(scopes: <String>['email']).signIn();

    // final GoogleSignInAuthentication googleAuth =
    //     await googleUser!.authentication;

    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );

    // return await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    // AuthResult authResult = await _auth.signInWithCredential(credential);

    // _user = authResult.user;

    // assert(!_user.isAnonymous);

    // assert(await _user.getIdToken() != null);

    // FirebaseUser currentUser = await _auth.currentUser();

    // assert(_user.uid == currentUser.uid);
    print(credential);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  signup(BuildContext context) async {
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

      if (result != null) {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
        return result;
      } else {
        print('value is null');
      }
      // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }
  // }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
