import 'package:chat/constens/colors.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({
    super.key,
    required this.message,
    required this.color,
    required this.align,
    required this.left,
    required this.right,
  });
  final String message;
  final Color color;
  final AlignmentGeometry align;
  final Radius left;
  final Radius right;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Container(
        padding:  EdgeInsets.all(25),
        margin:  EdgeInsets.all(15),
        decoration:  BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              bottomLeft: left,
              bottomRight: right,
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )),
        child: Text(
          "$message",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
