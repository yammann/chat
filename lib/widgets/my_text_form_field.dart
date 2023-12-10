import 'package:chat/constens/colors.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  String? hintText;
  final controller;
  bool obscure;
  //  Function(String) validate;
  TextInputType type;
  MyTextFormField(
      {super.key,
      this.hintText,
      this.controller,
      this.type = TextInputType.text,
      this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      validator: (value) {
        if (value!.isEmpty) {
          return "has worning";
        }
      },
      keyboardType: type,
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: kPrimaryColor)),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
