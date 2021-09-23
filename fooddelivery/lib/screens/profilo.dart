import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profilo extends StatelessWidget {
  const Profilo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: user != null
                        ? NetworkImage(user.photoURL)
                        : NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJtLpm3-3xKOxqDr5UIDqMctl9MUC5YYzI0w&usqp=CAU'),
                    radius: 50,
                  ),
                  Text(
                    user != null ? user.displayName : "",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(user != null ? user.email : ""),
                  ElevatedButton(
                      onPressed: () {
                        showAlertDialog(context);
                      },
                      child: Icon(Icons.logout))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Si"),
      onPressed: () {
        _signOut(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Sei sicuro di voler uscire?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
