import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LimitBandCreation {
  // late String uid;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<Map> getBandLimitation(String uid) async {
    return await users.where('uid', isEqualTo: uid).get().then((value) => {
          'docId': value.docs.first.id,
          'bandLimitation': value.docs.first['bandLimitation']
        });
  }

  Future<bool> isNotMaxReached(String uid) async {
    final Map data = await getBandLimitation(uid);
    final String userDocId = data['docId'];
    final int userBandLimitationCount = data['bandLimitation'];

    if (userBandLimitationCount > 0) {
      users
          .doc(userDocId)
          .update({'bandLimitation': userBandLimitationCount - 1});
      return true;
    } else {
      return false;
    }
  }

  addBandLimitPoint(String uid) async {
    final Map data = await getBandLimitation(uid);
    final String userDocId = data['docId'];
    final int userBandLimitationCount = data['bandLimitation'];

    if (userBandLimitationCount <= 3) {
      users
          .doc(userDocId)
          .update({'bandLimitation': userBandLimitationCount + 1});
      return true;
    } else {
      return false;
    }
  }
}
