import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({this.onTap, required this.text});
  String text;
  VoidCallback?onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 48,
        width: double.infinity,
        child: Center(child: Text(text)),
      ),
    );
  }
}
