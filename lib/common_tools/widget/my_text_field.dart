import 'package:flutter/material.dart';

Widget MyTextView(String text, double size) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    textAlign: TextAlign.center,
  );
}
