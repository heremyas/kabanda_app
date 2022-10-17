import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kabanda_app/utilities/limitBandCreation.dart';

Future<bool> deleteBand(bandId) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  if (await LimitBandCreation().addBandLimitPoint(uid)) {
    await FirebaseFirestore.instance
        .collection('created_bands')
        .doc(bandId)
        .delete()
        .then((value) => value);
    return true;
  } else {
    return false;
  }
}
