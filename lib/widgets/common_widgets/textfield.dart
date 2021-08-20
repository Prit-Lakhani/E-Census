import 'package:e_census_2021/constants/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreenTextField extends StatelessWidget {
  Icon icon;
  String hint;
//  Function onChange;
Function(String) onChanged;
  TextInputType input;
  TextEditingController textEditingController;
  LoginScreenTextField(
      {this.icon,
      this.hint,
      /*this.onChange,*/ this.input,
      this.textEditingController,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 5,
          right: SizeConfig.safeBlockHorizontal * 5),
      child: TextField(
        onChanged: (value){
            onChanged(value);
        },
        keyboardType: input,
        obscureText: input == TextInputType.visiblePassword ? true : false,
        cursorColor: Colors.blue,
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          prefixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          labelText: hint,
          labelStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockHorizontal * 4,
            color: Colors.grey,
          ),
        ),
//        onChanged: onChange
      ),
    );
  }
}
