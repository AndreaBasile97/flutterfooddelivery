import 'package:flutter/material.dart';
import 'package:fooddelivery/backend/authentication.dart';
// import 'package:flutter/services.dart';

//Dichiarazione classe StatefulWidget
class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginForm();
}

//State dello StatefulWidget
class _LoginForm extends State<LoginForm> {
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
            ElevatedButton(
              onPressed: () {
                Authentication.logInWithEmail(
                    emailController.text, passwordController.text, context);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
