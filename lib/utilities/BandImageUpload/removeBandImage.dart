import 'package:firebase_storage/firebase_storage.dart';

Future removeBandImage(imagePath) async {
  final ref = FirebaseStorage.instance.ref().child('files/$imagePath/file');
  print('files/$imagePath/file');
  await ref.delete();
  return true;
}
