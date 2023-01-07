

import 'package:flutter/material.dart';

Widget responseButtonWidget(
    {required String text,
    required Color backgroundColor,
    required VoidCallback onPressed}) {
  return TextButton(
  
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor), 
        minimumSize: MaterialStateProperty.all(const Size(100, 50)),   
        ),
    onPressed: onPressed,
    
    child: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ), 
    
  );
}


