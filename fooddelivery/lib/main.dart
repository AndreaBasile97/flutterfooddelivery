import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/screens/master.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return MaterialApp(
          title: 'Brodelivery',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              accentColor: Colors.orange,
              primarySwatch: Colors.orange,
              brightness: Brightness.dark,
              fontFamily: 'Quicksand'),
          home: Master());
    }
    if (FirebaseAuth.instance.currentUser == null) {
      return MaterialApp(
          title: 'Brodelivery',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              accentColor: Colors.orange,
              primarySwatch: Colors.orange,
              brightness: Brightness.dark,
              fontFamily: 'Quicksand'),
          home: LoginScreen());
    } else
      return CircularProgressIndicator();
  }
}
