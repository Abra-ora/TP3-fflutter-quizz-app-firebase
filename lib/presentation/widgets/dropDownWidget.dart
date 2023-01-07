import 'package:flutter/material.dart';

Widget dropDownWidget(
    {required String hintText,
    required List<String> items,
    required selectedItem ,
    required Function(String?)? onChanged}) {
  return DropdownButtonFormField<String>(
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    value: selectedItem,
    items: items.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (value) {
      if(value != null){
        onChanged!(value);
      }
    },
  );
}
