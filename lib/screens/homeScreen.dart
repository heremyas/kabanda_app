import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kabanda_app/screens/createBand.dart';
import 'package:kabanda_app/widgets/appBar.dart';
import 'package:kabanda_app/widgets/feedItemsList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        // body: Center(
        //     child: Column(children: [
        //   Text(FirebaseAuth.instance.currentUser!.displayName!),
        //   Text(FirebaseAuth.instance.currentUser!.email!),
        body: Column(
          children: [
            Container(
                child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateBandScreen()));
              },
              child: Text('create band'),
            )),
            Expanded(child: FeedItemsList()),
          ],
        ));
  }
}
