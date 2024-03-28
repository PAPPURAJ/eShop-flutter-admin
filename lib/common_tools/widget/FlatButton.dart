import 'package:flutter/material.dart';

Widget flatButton(BuildContext context, String text, Widget widget) {
  return ElevatedButton(
    onPressed: () async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => widget));
    },
    child: Text(
      text,
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    ),

  );
}
