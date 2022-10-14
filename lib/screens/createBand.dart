import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kabanda_app/widgets/appBar.dart';
import 'package:kabanda_app/widgets/bandForm.dart';

class CreateBandScreen extends StatefulWidget {
  const CreateBandScreen({Key? key}) : super(key: key);

  @override
  State<CreateBandScreen> createState() => _CreateBandScreenState();
}

class _CreateBandScreenState extends State<CreateBandScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(),
      body: BandForm(),
    );
  }
}
