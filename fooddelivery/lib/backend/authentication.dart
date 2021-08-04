import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fooddelivery/interactive/snackbar.dart';
import 'package:fooddelivery/screens/master.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<ScaffoldFeatureController> logInWithEmail(
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
          return snackBar(
              context,
              "La tua mail non è stata verificata, controlla la tua casella elettronica",
              Icons.error,
              Colors.red);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return snackBar(context, "Utente non trovato", Icons.error, Colors.red);
      } else if (e.code == 'wrong-password') {
        return snackBar(context, "Password errata", Icons.error, Colors.red);
      }
    }
    return null;
  }

  static Future<ScaffoldFeatureController> signInWithEmail(
      String useremail, String userpassword, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: useremail, password: userpassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return snackBar(
            context, "Password troppo debole", Icons.error, Colors.red);
      } else if (e.code == 'email-already-in-use') {
        return snackBar(context, "Email già usata", Icons.error, Colors.red);
      }
    } catch (e) {
      print(e);
    }
    User user = FirebaseAuth.instance.currentUser;
    if (!user.emailVerified) {
      user.sendEmailVerification();
      return snackBar(context, "Ti abbiamo inviato una email di verifica",
          Icons.done, Colors.green);
    }
    return null;
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
