import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kabanda_app/utilities/addBand.dart';
import 'package:kabanda_app/utilities/fileUpload.dart';
import 'package:kabanda_app/utilities/queryUserById.dart';
import 'package:kabanda_app/utilities/readGenres.dart';
import 'package:kabanda_app/widgets/imagePicker.dart';

class BandForm extends StatefulWidget {
  BandForm({Key? key}) : super(key: key);

  @override
  State<BandForm> createState() => _BandFormState();
}

class _BandFormState extends State<BandForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  final List membersController = [TextEditingController()];
  String selectedGenre = 'Rock';

  List<Map> members = [];
  List<Widget> bandImage = [];
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
            ...members,

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (members.length < 7) {
                            members.add(addMember(members.length));
                            membersController.add(TextEditingController());
                          }
                        });
                      },
                      child: Text('Add')),
                  SizedBox(
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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (bandImage.isEmpty) {
                          final result = showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc) {
                                return FilePicker();
                              }).then((value) {
                            setState(() {
                              if (bandImage.length < 2 && value != null) {
                                bandImage.add(Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(File(value)),
                                ));
                              }
                            });
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('You can only upload one image.')));
                        }
                      },
                      child: Text('Upload Band Image')),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (bandImage.isNotEmpty) {
                            bandImage.clear();
                          }
                        });
                      },
                      child: Text('Remove'))
                ],
              ),
            ),

            ...bandImage,
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
                            description: descriptionController.value.text)) {
                          Navigator.pop(context);
                        } else {
                          print('band limitation reached');
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

  Map addMember(int members) {
    return {
      'widget': Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: membersController[membersController.length],
          initialValue: '',
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Member ${members + 1}',
          ),
        ),
      ),
      'controller': TextEditingController()
    };
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
