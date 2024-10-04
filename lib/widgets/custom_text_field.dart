import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({super.key, this.hintText,this.onChanged,this.obscure =false});
  String? hintText;
   Function(String)? onChanged;
   bool? obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure!,
      validator: (data) {
        if(data !.isEmpty){
          return 'value is required';
        }
      },
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        
        hintStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.normal),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
