import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fooddelivery/screens/master.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static void logInWithEmail(
      String useremail, String userpassword, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: useremail, password: userpassword)
          .then((value) {
        User user = FirebaseAuth.instance.currentUser;
        if (user.emailVerified) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Master()));
        } else {
          print("Mail non verificata");
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Account non trovato.');
      } else if (e.code == 'wrong-password') {
        print('Password errata.');
      }
    }
  }

  static void signInWithEmail(String useremail, String userpassword,
      {BuildContext context}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: useremail, password: userpassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    User user = FirebaseAuth.instance.currentUser;
    if (!user.emailVerified) {
      user.sendEmailVerification();
    }
  }

  static Future<User> signInWithGoogle({BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // ...
          } else if (e.code == 'invalid-credential') {
            // ...
          }
        } catch (e) {
          // ...
        }
      }
    }

    return user;
  }
}
