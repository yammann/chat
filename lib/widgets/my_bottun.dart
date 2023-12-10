import 'package:flutter/material.dart';

class MyBottun extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  MyBottun({super.key, required this.title,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(fontSize: 20, color: Color(0xff408bc1)),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
          ),
        ));
  }
}
