import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kabanda_app/utilities/deleteBand.dart';
import 'package:kabanda_app/widgets/appBar.dart';

class BandScreen extends StatefulWidget {
  const BandScreen({Key? key, required this.data}) : super(key: key);

  final Map data;

  @override
  State<BandScreen> createState() => _BandScreenState();
}

class _BandScreenState extends State<BandScreen> {
  @override
  Widget build(BuildContext context) {
    final Map bandInformation = {
      "uid": 'User ID',
      'bandName': 'Band Name',
      'genre': 'Genre'
    };

    return Scaffold(
      appBar: customAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/en/f/f4/Ridetl.png'),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: bandInformation.length,
                  itemBuilder: (_, i) {
                    final key = bandInformation.keys.toList()[i];

                    return Card(
                        child: ListTile(
                      title:
                          Text(bandInformation[key] + ': ' + widget.data[key]),
                      subtitle: Text(''),
                    ));
                  })),
          FirebaseAuth.instance.currentUser!.uid == widget.data['uid']
              ? ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ARE YOU SURE?',
                                style: TextStyle(
                                    color: Colors
                                        .red)), // To display the title it is optional
                            content: Text(
                                'This cannot be undone'), // Message which will be pop up on the screen
                            // Action widget which will provide the user to acknowledge the choice
                            actions: [
                              FlatButton(
                                // FlatButton widget is used to make a text to work like a button
                                textColor: Colors.black,
                                onPressed: () {
                                  Navigator.pop(context);
                                }, // function used to perform after pressing the button
                                child: Text('CANCEL'),
                              ),
                              FlatButton(
                                textColor: Colors.black,
                                onPressed: () async {
                                  if (await deleteBand(widget.data['bandId'])) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } else {
                                    print('loading');
                                  }
                                },
                                child: Text('DELETE'),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                )
              : ElevatedButton(onPressed: () {}, child: Text('Join'))
        ],
      ),
    );
  }
}
