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
  final GlobalKey<FormFieldState<String>> _passwordField =
      GlobalKey<FormFieldState<String>>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  String _email;
  //String _phoneNumber;
  String _password;
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

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 15),
      key: widget.fieldKey,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
