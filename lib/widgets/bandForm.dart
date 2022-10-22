import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kabanda_app/utilities/addBand.dart';
import 'package:kabanda_app/utilities/displayBandImage.dart';
import 'package:kabanda_app/utilities/BandImageUpload/fileUpload.dart';
import 'package:kabanda_app/utilities/queryUserById.dart';
import 'package:kabanda_app/utilities/readGenres.dart';
import 'package:kabanda_app/widgets/bandImageSelection.dart';
import 'package:kabanda_app/widgets/imagePicker.dart';
import 'package:path/path.dart';

class BandForm extends StatefulWidget {
  BandForm({Key? key}) : super(key: key);

  @override
  State<BandForm> createState() => _BandFormState();
}

class _BandFormState extends State<BandForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  // final List membersController = [TextEditingController()];
  String selectedGenre = 'Rock';

  List members = [];
  List<File> bandImage = [];
  File? _bandImage;

  String testState = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Create Band'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Band Name',
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     controller: genreController,
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return 'Please enter some text';
            //       }
            //       return null;
            //     },
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'Genre',
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Genre'),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: readGenres(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonFormField(
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        isExpanded: true,
                        value: 'Rock',
                        items: addGenreItem(snapshot.data!.docs),
                        onChanged: (value) {
                          setState(() {
                            selectedGenre = value.toString();
                          });
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Members'),
            ),
            // Column(
            //   children: members.length == 0
            //       ? members.map((e) {
            //           return Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: TextFormField(
            //                 controller: e,
            //                 initialValue: '',
            //                 validator: (value) {
            //                   if (value!.isEmpty) {
            //                     return 'Please enter some text';
            //                   }
            //                   return null;
            //                 },
            //                 decoration: InputDecoration(
            //                   border: OutlineInputBorder(),
            //                   labelText: 'Member ${members.length + 1}',
            //                 ),
            //               ));
            //         }).toList()
            //       : [],
            // ),

            ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: members.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: members[index],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Member',
                      ),
                    ));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (members.length < 7) {
                            members.add(TextEditingController());
                            // membersController.add(TextEditingController());
                          }
                        });
                      },
                      child: Text('Add')),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (members.isNotEmpty) {
                            members.removeLast();
                          }
                        });
                      },
                      child: Text('Remove')),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Description'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'What is your band about?'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Band Image'),
            ),

            BandImageSelection(),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       ElevatedButton(
            //           onPressed: () async {
            //             if (bandImage.isEmpty) {
            //               showModalBottomSheet(
            //                   context: context,
            //                   builder: (BuildContext bc) {
            //                     return FilePicker();
            //                   }).then((value) async {
            //                 setState(() {
            //                   if (bandImage.length <= 1 && value != null) {
            //                     _bandImage = value;
            //                     bandImage.add(value);
            //                   }
            //                 });
            //               });
            //             } else {
            //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //                   content: Text('You can only upload one image.')));
            //             }
            //           },
            //           child: Text('Add Band Image')),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       ElevatedButton(
            //           onPressed: () {
            //             setState(() {
            //               if (bandImage.isNotEmpty) {
            //                 bandImage.clear();
            //               }
            //             });
            //           },
            //           child: Text('Remove'))
            //     ],
            //   ),
            // ),

            // ListView.builder(
            //     physics: const BouncingScrollPhysics(),
            //     scrollDirection: Axis.vertical,
            //     shrinkWrap: true,
            //     itemCount: bandImage.length,
            //     itemBuilder: (context, index) {
            //       return FutureBuilder(builder: )

            //       // Padding(
            //       //   padding: const EdgeInsets.all(8.0),
            //       //   child: Image.file(File(bandImage[index].path)),
            //       // );
            //     }),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      final uid = FirebaseAuth.instance.currentUser!.uid;
                      if (_formKey.currentState!.validate()) {
                        if (await addBand(
                            uid: uid,
                            bandName: nameController.value.text,
                            genre: selectedGenre,
                            description: descriptionController.value.text,
                            members: members.map((e) => e.value.text).toList(),
                            bandImageUrl: await convertToBandImageUrl(
                                basename(bandImage.first.path)))) {
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Band Creation Limitation Reachedx')));
                        }
                      }
                    },
                    child: Text('Create')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> addGenreItem(
      List<QueryDocumentSnapshot<Object?>> genres) {
    List<DropdownMenuItem<String>> genreList = [];

    genres.forEach((e) {
      genreList.add(DropdownMenuItem(
        value: (e.data() as Map)['name'],
        child: Text((e.data() as Map)['name']),
      ));
    });

    return genreList;
  }
}
