import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class ImageUpload {
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  File? _image;

  Future imgFromGallery() async {
    final selectedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedFile != null) {
      _image = File(selectedFile.path);

      // return true;
      return selectedFile.path;
    } else {
      // return 'no image selected';
      print('no image selected');
      return null;
    }
  }

  Future uploadFile() async {
    if (_image == null) return;
    final fileName = basename(_image!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(_image!);
    } catch (e) {
      print('error occured');
    }
  }
}
