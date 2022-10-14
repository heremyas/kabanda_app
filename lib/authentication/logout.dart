import 'package:firebase_auth/firebase_auth.dart';

logOut() {
  FirebaseAuth.instance.signOut();
}
