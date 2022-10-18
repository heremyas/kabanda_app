import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class ImageUpload {
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  File? _image;

  Future<Map> imgFromGallery(context) async {
    final selectedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedFile != null) {
      _image = File(selectedFile.path);

      return {
        'downloadUrl': await uploadFile(),
        'imagePath': basename(_image!.path)
      };
    } else {
      // return 'no image selected';
      return {};
    }
  }

  Future uploadFile() async {
    // if (_image == null) return;
    final fileName = basename(_image!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(_image!);
      print('success');
      return ref.getDownloadURL();
    } catch (e) {
      print('error occured');
      return null;
    }
  }
}
