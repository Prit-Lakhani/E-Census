import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String assetImage;
  final Function onTap;
  const CategoryCard({
    Key key,
    @required this.assetImage,
    @required this.onTap,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(assetImage),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.27,
                  color: Color(0xFF17262A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
