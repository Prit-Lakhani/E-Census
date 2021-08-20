import 'package:e_census_2021/constants/config.dart';
import 'package:e_census_2021/screens/enumerator/enumerator_home.dart';
import 'package:e_census_2021/screens/form_status.dart';
import 'package:e_census_2021/widgets/category_card.dart';
import 'package:flutter/material.dart';

class EnumeratorMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select option"),
        ),
        body: SafeArea(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                CategoryCard(
                  assetImage: "assets/3.jpg",
                  onTap: () => changeScreen(
                    context: context,
                    widget: EnumeratorHomePage(),
                  ),
                  title: "Without Aadhar Card",
                ),
                SizedBox(
                  width: 10,
                ),
                CategoryCard(
                  assetImage: "assets/1.png",
                  onTap: () =>
                      changeScreen(context: context, widget: UserFormStatus()),
                  title: "With Aadhar Card",
                ),
              ],
            ),
          ),
        ));
  }
}
