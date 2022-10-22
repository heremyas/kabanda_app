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
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customAppBar(),
          body: BandForm(),
        ),
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Wait!'),
                    content: const Text(
                        'Are you sure you want to quit band creation?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text('Yes')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'))
                    ],
                  ));
          return true;
        });
  }
}
