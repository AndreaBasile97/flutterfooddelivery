import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_signin_button/button_list.dart';
// import 'package:fooddelivery/backend/authentication.dart';
import 'package:fooddelivery/interactive/google_sign_in_button.dart';
import 'package:fooddelivery/screens/registration_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Bro Delivery - Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Roboto')),
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: SignInButton(
                  Buttons.Email,
                  text: "Registrati con email",
                  onPressed: () {
                    // cliccando registra automaticamente un utente mockato
                    // await Authentication.signInWithEmail(context: context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationForm()),
                    );
                  },
                )),
            Padding(padding: EdgeInsets.all(10.0), child: GoogleSignInButton()),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                    child: Text("Log In Using Email",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scaffold()),
                      );
                    }))
          ]),
    ));
  }
}
