import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LimitBandCreation {
  // late String uid;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<int> getBandLimitation(String uid) async {
    return await users
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) => value.docs.first['bandLimitation']);
  }

  Future<bool> isNotMaxReached(String uid) async {
    int userBandLimitationCount = await getBandLimitation(uid);

    if (userBandLimitationCount > 0) {
      users.doc().update({'bandLimitation': userBandLimitationCount - 1});
      return true;
    } else {
      return false;
    }
  }
}
