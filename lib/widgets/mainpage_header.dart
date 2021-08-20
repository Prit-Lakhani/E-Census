import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHeaderText extends StatelessWidget {
  String mainHeader;
  String subHeader;
  Color mainHeaderColor;
  Color subHeaderColor;
  MainHeaderText({
    @required this.mainHeader,
    @required this.subHeader,
    @required this.mainHeaderColor,
    @required this.subHeaderColor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              mainHeader,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 4),
            child: Text(
              subHeader,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
