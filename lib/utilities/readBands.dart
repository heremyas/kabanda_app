import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kabanda_app/model/band.dart';

CollectionReference<Map<String, dynamic>> readBands() {
  final data = FirebaseFirestore.instance.collection('created_bands');
  return data;
}
