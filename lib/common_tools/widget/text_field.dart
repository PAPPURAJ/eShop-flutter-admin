import 'package:flutter/material.dart';

Widget myTextField(String hint) {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    initialValue: '',
    decoration: InputDecoration(
      hintText: hint,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
  );
}

Widget myPassTextField(
    String hint, TextEditingController controller, double border) {
  return TextFormField(
    controller: controller,
    autofocus: false,
    obscureText: true,
    decoration: InputDecoration(
      hintText: hint,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(border)),
    ),
  );
}

Widget myRecTextField(
    String hint, TextEditingController myController, double border) {
  return TextFormField(
    controller: myController,
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    decoration: InputDecoration(
      hintText: hint,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(border)),
    ),
  );
}

Widget getTextField(
    String labeltext, String hint, TextEditingController controller) {
  return Container(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labeltext,
          hintText: hint,
        ),
        autofocus: false,
        controller: controller,
      ));
}
