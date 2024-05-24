

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {


  var textInputAction = TextInputAction.next;
  var keyboardType ;
  var label;
  var controller ;
  IconButton? suffixIcon ;



  CustomTextFormField(
      {
        this.suffixIcon,
        required this.textInputAction,
        required this.keyboardType,
        required this.label,
        required this.controller,
        super.key
      });




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(

        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType,
        textInputAction:textInputAction,
        autocorrect: true,
        decoration: InputDecoration(
          suffixIcon:suffixIcon,
          labelText: label,

        ),
        validator:(value){
          if(value!.isEmpty){
            return " Please enter the valid $label ";
          }
          return null;
        },

      ),
    );
  }
}
