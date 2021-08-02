import 'package:flutter/material.dart';
import 'package:fooddelivery/backend/authentication.dart';
// import 'package:flutter/services.dart';

//Dichiarazione classe StatefulWidget
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationForm();
}

//State dello StatefulWidget
class _RegistrationForm extends State<RegistrationForm> {
  //Campi che comporranno lo stato del widget
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;

  //Contenuto del widget
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 24.0,
            ),
            TextFormField(
              style: TextStyle(fontSize: 15),
              controller: emailController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(Icons.mail),
                  hintText: "La tua email",
                  labelText: "Email"),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              style: TextStyle(fontSize: 15),
              controller: passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: "Password",
                icon: Icon(Icons.lock),
                border: const UnderlineInputBorder(),
                filled: true,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              style: TextStyle(fontSize: 15),
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: "Reinserisci password",
                icon: Icon(Icons.lock),
                border: const UnderlineInputBorder(),
                filled: true,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                Authentication.signInWithEmail(
                    emailController.text, passwordController.text);
              },
              child: const Text('Registrati'),
            ),
          ],
        ),
      ),
    );
  }
}
