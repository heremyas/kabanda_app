import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kabanda_app/utilities/BandImageUpload/fileUpload.dart';
import 'package:kabanda_app/utilities/BandImageUpload/removeBandImage.dart';

class BandImageSelection extends StatefulWidget {
  const BandImageSelection({Key? key}) : super(key: key);

  @override
  State<BandImageSelection> createState() => _BandImageSelectionState();
}

class _BandImageSelectionState extends State<BandImageSelection> {
  bool isImageUploaded = false;
  bool isUploading = false;
  final String defaultImage = 'assets/images/defaultBandImage.jpeg';
  ValueNotifier<Map> uploadedBandImageUrl = ValueNotifier<Map>({});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        height: 400,
        child: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: !isImageUploaded
                        ? AssetImage(defaultImage) as ImageProvider
                        : ValueListenableBuilder(
                            valueListenable: uploadedBandImageUrl,
                            builder: ((context, value, child) =>
                                NetworkImage(value))) as NetworkImage,
                    fit: BoxFit.cover)),
            child: Center(
              child: isUploading
                  ? const CircularProgressIndicator()
                  : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => SafeArea(
                                        child: Container(
                                      child: Wrap(
                                        children: <Widget>[
                                          ListTile(
                                              leading:
                                                  Icon(Icons.photo_library),
                                              title: Text('Gallery'),
                                              onTap: () async {
                                                Navigator.pop(context);
                                                setState(() {
                                                  isUploading = true;
                                                });
                                                final uploadedImageUrl =
                                                    await ImageUpload()
                                                        .imgFromGallery(
                                                            context);
                                                if (uploadedImageUrl != null) {
                                                  setState(() {
                                                    isUploading = false;
                                                    isImageUploaded = true;
                                                    uploadedBandImageUrl =
                                                        uploadedImageUrl;
                                                  });
                                                } else {
                                                  print(
                                                      'no img selected or error occured');
                                                  setState(() {
                                                    isUploading = false;
                                                  });
                                                }

                                                // final File? res =
                                                //     await ImageUpload().imgFromGallery();
                                                // if (res!.path != null) {
                                                //   return Navigator.pop(context, res);
                                                // }
                                                // Navigator.of(context).pop('test');
                                              }),
                                          // new ListTile(
                                          //   leading: new Icon(Icons.photo_camera),
                                          //   title: new Text('Camera'),
                                          //   onTap: () {
                                          //     imgFromCamera();
                                          //     Navigator.of(context).pop();
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    )));

                            // if (bandImage.isEmpty) {
                            //   showModalBottomSheet(
                            //       context: context,
                            //       builder: (BuildContext bc) {
                            //         return FilePicker();
                            //       }).then((value) async {
                            //     setState(() {
                            //       if (bandImage.length <= 1 && value != null) {
                            //         _bandImage = value;
                            //         bandImage.add(value);
                            //       }
                            //     });
                            //   });
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //       content: Text('You can only upload one image.')));
                            // }
                          },
                          child: Text(!isImageUploaded
                              ? 'Upload Band Image'
                              : 'Change Band Image')),
                      SizedBox(
                        width: 10,
                      ),
                      !isImageUploaded
                          ? Text('')
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isImageUploaded = false;
                                  removeBandImage(
                                          uploadedBandImageUrl['imagePath'])
                                      .then((value) => print(value));
                                });
                              },
                              child: Text('Remove'))
                    ]),
              // child:
              //     Image(image: AssetImage('assets/images/defaultBandImage.jpeg')),
            )));
  }
}
