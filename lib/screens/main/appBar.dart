import 'package:flutter/material.dart';

AppBar appBar_Screen(context) {
  return AppBar(
    title: const Text(
      "Smey's Music Videos",
      style: TextStyle(
        color: Colors.red,
        fontSize: 22,
        fontFamily: 'Impact',
        fontWeight: FontWeight.bold,
        // textAlign: TextAlign.center,
      ),
    ),
  );
}
