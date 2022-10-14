import 'package:flutter/material.dart';
import 'package:kabanda_app/model/band.dart';

Widget buildBand(Band band) => ListTile(
      title: Text(band.name),
      subtitle: Text(band.genre),
    );
