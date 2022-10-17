import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabanda_app/utilities/limitBandCreation.dart';
import 'package:kabanda_app/utilities/queryUserById.dart';

Future<bool> addBand(
    {required String uid,
    required String bandName,
    required String genre,
    required String description,
    required List members,
    required String bandImagePath}) async {
  if (await LimitBandCreation().isNotMaxReached(uid)) {
    final docUser =
        FirebaseFirestore.instance.collection('created_bands').doc();

    final jsonData = {
      'uid': uid,
      'bandName': bandName,
      'genre': genre,
      'description': description,
      'members': members,
      'bandImagePath': bandImagePath
    };

    await docUser.set(jsonData);
    return true;
  } else {
    return false;
  }
}
