import 'package:flutter/material.dart';

ScaffoldFeatureController errorSnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: <Widget>[
          Icon(
            Icons.error_outline,
            color: Colors.red,
          ),
          Text("Autenticazione fallita!"),
        ],
      ),
    ),
  );
}
