import 'package:flutter/material.dart';

Widget buttonWidget(
    {required String text,
    required Color textColor,
    required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(100, 80),
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    ),
    onPressed: onPressed,
    child: Text(text),
  );
}
