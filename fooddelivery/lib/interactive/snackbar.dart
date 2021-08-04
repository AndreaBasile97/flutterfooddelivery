import 'package:flutter/material.dart';

ScaffoldFeatureController snackBar(
    BuildContext context, String text, IconData icon, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          Flexible(child: Text(text)),
        ],
      ),
    ),
  );
}
