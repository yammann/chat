import 'package:flutter/material.dart';


MySnackBar(BuildContext context,String text){
   ScaffoldMessenger.of(context). showSnackBar(
            SnackBar(content: Text (text,style: TextStyle(color: Colors.white),),
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
            backgroundColor: Color.fromARGB(255, 85, 163, 253),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(milliseconds: 500),
            action: SnackBarAction(label: "Cancel", onPressed: (){}),));
}
