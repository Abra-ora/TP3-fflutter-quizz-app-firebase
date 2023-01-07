import 'package:flutter/material.dart';

Widget textFormFieldWidget(
    {required String hintText,
    required TextEditingController controller,
    required VoidCallback onTap}) {
  return TextFormField (
    controller: controller,
    onTap: onTap,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Veuillez remplir le champ de question';
      }else if(value.length < 10){
          return 'Veuillez saisir au moins 10 caractères';
      }
      if(hintText.contains("lien")){
        if(!value.endsWith(".jpg") & !value.endsWith(".png") & !value.endsWith(".jpeg")){
          return 'Veuillez saisir un lien valide';
        }
      }
      return null;
    },
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
  );
}