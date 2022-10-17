import 'package:firebase_storage/firebase_storage.dart';

Future<String> convertToBandImageUrl(String bandImageFileName) async {
  final ref = FirebaseStorage.instance
      .ref()
      .child('files/image_picker2080679742066617828.jpg/file');
  var url = await ref.getDownloadURL();

  return url;
}
