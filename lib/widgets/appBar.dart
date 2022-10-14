import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabanda_app/authentication/logout.dart';

AppBar customAppBar() {
  final dp = FirebaseAuth.instance.currentUser!.photoURL!;
  return AppBar(
    centerTitle: true,
    title: Text("Kabanda"),
    leading: Container(
      padding: const EdgeInsets.all(10),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(dp),
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            logOut();
          },
          icon: const Icon(Icons.exit_to_app))
    ],
  );
}
