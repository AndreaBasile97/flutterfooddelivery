import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:fooddelivery/backend/authentication.dart';
import 'package:fooddelivery/interactive/snackbar.dart';
import 'package:fooddelivery/screens/master.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Google,
      text: "Login con Google",
      padding: EdgeInsets.only(top: 8, bottom: 8),
      onPressed: () async {
        setState(() {});

        User user = await Authentication.signInWithGoogle(context: context);

        setState(() {});

        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Master(),
            ),
          );
        } else {
          return snackBar(
              context, "Autenticazione Fallita", Icons.error, Colors.red);
        }
      },
    );
  }
}
