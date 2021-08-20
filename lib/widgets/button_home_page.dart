import 'package:e_census_2021/constants/colors.dart';
import 'package:e_census_2021/constants/config.dart';
import 'package:flutter/material.dart';

class ButtonHomePage extends StatelessWidget {
  Icon icon;
  String name;
  Function onPressed;
  ButtonHomePage({
    this.icon,
    this.name,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              gradient: kPrimaryGradient,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )),
          width: SizeConfig.blockSizeHorizontal * 80,
          //color: Colors.amberAccent,
          child: InkWell(
            onTap: onPressed,
            splashColor: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: icon,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    name,
                    style: TextStyle(
                        color: kPrimaryBackgroundColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
