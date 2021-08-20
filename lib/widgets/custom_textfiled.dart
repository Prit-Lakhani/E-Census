import 'package:e_census_2021/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool prefix;
  final IconData icon;
  final Function validator;

  double _width;

  CustomTextField({
    this.hint,
    this.validator,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.prefix = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 10,
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        keyboardType: keyboardType,
        cursorColor: Colors.blue,
        // maxLength: maxlength,

        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue, size: 20),
          hintText: hint,
          prefixText: prefix ? "+91" : "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
          errorMaxLines: 1,
        ),
      ),
    );
  }
}

String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
  if (value.length != 12)
    return 'Aadhar Number must be of 12 digit';
  else
    return null;
}

String emailValidator(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Email format is invalid';
  } else {
    return null;
  }
}

String pwdValidator(String value) {
  if (value.length < 4) {
    return 'Password must be longer than 4 characters';
  } else {
    return null;
  }
}

String validateName(String value) {
  if (value.length < 3)
    return 'Name must be more than 2 charater';
  else
    return null;
}
