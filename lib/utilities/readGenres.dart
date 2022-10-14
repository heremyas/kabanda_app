import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot<Map<String, dynamic>>> readGenres() =>
    FirebaseFirestore.instance.collection('genres').snapshots();
