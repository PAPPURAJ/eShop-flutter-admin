import 'package:flutter/material.dart';

Decoration getBackground() {
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/background.png"),
      fit: BoxFit.cover,
    ),
  );
}

Decoration getLayBackground() {
  return const BoxDecoration(
    image: DecorationImage(
      opacity: 0.2,
      image: AssetImage("assets/images/lay_back.png"),
      fit: BoxFit.fill,
    ),
  );
}
