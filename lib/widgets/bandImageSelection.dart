import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kabanda_app/utilities/fileUpload.dart';

class BandImageSelection extends StatefulWidget {
  const BandImageSelection({Key? key}) : super(key: key);

  @override
  State<BandImageSelection> createState() => _BandImageSelectionState();
}

class _BandImageSelectionState extends State<BandImageSelection> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = 'assets/images/defaultBandImage.jpeg';

    Widget _uploadState =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => SafeArea(
                        child: Container(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('Gallery'),
                              onTap: () async {
                                await ImageUpload().imgFromGallery();

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
          child: Text('Upload Band Image')),
      SizedBox(
        width: 10,
      ),
      ElevatedButton(
          onPressed: () {
            setState(() {
              // if (bandImage.isNotEmpty) {
              //   bandImage.clear();
              // }
            });
          },
          child: Text('Remove'))
    ]);

    return Container(
      padding: EdgeInsets.all(8.0),
      height: 400,
      child: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imageUrl), fit: BoxFit.cover)),
        child: Center(child: _uploadState),
      ),
      // child:
      //     Image(image: AssetImage('assets/images/defaultBandImage.jpeg')),
    );
  }
}
