// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:kabanda_app/utilities/fileUpload.dart';

// class FilePicker extends StatelessWidget {
//   const FilePicker({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         child: Wrap(
//           children: <Widget>[
//             ListTile(
//                 leading: Icon(Icons.photo_library),
//                 title: Text('Gallery'),
//                 onTap: () async {
//                   final File? res = await ImageUpload().imgFromGallery();
//                   if (res!.path != null) {
//                     return Navigator.pop(context, res);
//                   }
//                   // Navigator.of(context).pop('test');
//                 }),
//             // new ListTile(
//             //   leading: new Icon(Icons.photo_camera),
//             //   title: new Text('Camera'),
//             //   onTap: () {
//             //     imgFromCamera();
//             //     Navigator.of(context).pop();
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
