import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kabanda_app/utilities/login.dart';

AppBar customAppBar() {
  final dp = FirebaseAuth.instance.currentUser!.photoURL!;
  return AppBar(
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
            AuthService().signOut();
          },
          icon: const Icon(Icons.exit_to_app))
    ],
  );
}
