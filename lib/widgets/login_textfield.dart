import 'package:flutter/material.dart';

import '../constants/config.dart';

class LoginTextFeild extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  String labelText;
  TextInputType textInputType;
  bool isPasswordField = false;
  String validText = "Please Enter Some Details";
  Function validator;
  LoginTextFeild({
    @required this.hintText,
    @required this.labelText,
    this.textInputType,
    @required this.controller,
    @required this.validText,
    @required this.isPasswordField,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: isPasswordField,
        validator: validator,
        decoration: InputDecoration(
          //filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
          ),

          focusColor: Colors.white,
          fillColor: Colors.white,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 4,
            color: Colors.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
