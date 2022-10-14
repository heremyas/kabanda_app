import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future queryUserById(uid) async {
  String uName = await FirebaseFirestore.instance
      .collection('users')
      .where('uid', isEqualTo: uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    return querySnapshot.docs.single['displayName'];
  });

  return uName;
}
