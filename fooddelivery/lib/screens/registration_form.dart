import 'package:flutter/material.dart';
import 'package:fooddelivery/backend/authentication.dart';
import 'package:email_validator/email_validator.dart';

//Dichiarazione classe StatefulWidget
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationForm();
}

//State dello StatefulWidget
class _RegistrationForm extends State<RegistrationForm> {
  //Campi che comporranno lo stato del widget
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;
  //Contenuto del widget
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 24.0,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(fontSize: 15),
                controller: emailController,
                validator: (value) => EmailValidator.validate(value)
                    ? null
                    : "Inserisci una mail valida",
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: TextStyle(fontSize: 15),
                obscureText: _obscureText,
                controller: confirmPasswordController,
                validator: (val) {
                  if (val != passwordController.text)
                    return 'Le password non corrispondono';
                  return null;
                },
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
              !isLoading
                  ? ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (_form.currentState.validate()) {
                          await Authentication.signInWithEmail(
                              emailController.text,
                              passwordController.text,
                              context);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text('Registrati'),
                    )
                  : Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
