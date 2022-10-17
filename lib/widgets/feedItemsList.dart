import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kabanda_app/model/band.dart';
import 'package:kabanda_app/screens/bandScreen.dart';
import 'package:kabanda_app/utilities/displayBandImage.dart';
import 'package:kabanda_app/utilities/queryUserById.dart';
import 'package:kabanda_app/utilities/readBands.dart';
import 'package:kabanda_app/widgets/buildUser.dart';

class FeedItemsList extends StatelessWidget {
  const FeedItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: readBands().snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final bands = snapshot.data!.docs;

            return ListView.builder(
              itemCount: bands.length,
              itemBuilder: (_, i) {
                final data = bands[i].data() as Map;
                final id = bands[i].reference.id;
                data['bandId'] = id;
                return FutureBuilder(
                  future: queryUserById(data['uid']),
                  builder: (_, snap) {
                    if (snap.hasData) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BandScreen(
                                          data: data,
                                        )));
                          },
                          leading: CircleAvatar(
                              // radius: 50,
                              backgroundImage:
                                  NetworkImage(data['bandImagePath'])),
                          title: Text(data['bandName']),
                          subtitle: Text(data['genre'] +
                              '\n\nCreated by ' +
                              snap.data.toString()),
                          isThreeLine: true,
                        ),
                      );
                    } else {
                      return LinearProgressIndicator();
                    }
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
