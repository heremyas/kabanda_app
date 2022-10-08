import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kabanda_app/utilities/login.dart';
import 'package:kabanda_app/widgets/appBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Text('Sign in with Google', onTap),,
        child: InkWell(
          child: Text('Sign in with Google'),
          onTap: () {
            print('tapped');
            AuthService().signup(context);
          },
        ),
      ),
    );
  }
}
