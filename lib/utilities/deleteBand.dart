import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<bool> deleteBand(bandId) async {
  return FirebaseFirestore.instance
      .collection('created_bands')
      .doc(bandId)
      .delete()
      .then((value) => true);
}
