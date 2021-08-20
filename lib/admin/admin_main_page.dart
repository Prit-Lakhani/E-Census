import 'package:e_census_2021/constants/config.dart';
import 'package:e_census_2021/screens/admin/data_list.dart';
import 'package:e_census_2021/screens/admin/statistics.dart';
import 'package:e_census_2021/screens/admin_home.dart';
import 'package:e_census_2021/widgets/category_card.dart';
import 'package:flutter/material.dart';

class AdminMainPage extends StatefulWidget {
  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select option"),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(),
                    CategoryCard(
                      assetImage: "assets/1.png",
                      onTap: () => changeScreen(
                        context: context,
                        widget: DataList(
                          widgetCallFrom: "withAadharCard",
                        ),
                      ),
                      title: "With Aadhar Card",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CategoryCard(
                      assetImage: "assets/3.jfif",
                      onTap: () => changeScreen(
                          context: context,
                          widget: DataList(
                            widgetCallFrom: "withoutAadharCard",
                          )),
                      title: "Without Aadhar Card",
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(),
                    CategoryCard(
                      assetImage: "assets/2.jfif",
                      onTap: () => changeScreen(
                        context: context,
                        widget: DataList(
                          widgetCallFrom: "selfUser",
                        ),
                      ),
                      title: "Self Users",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CategoryCard(
                      assetImage: "assets/search.png",
                      onTap: () => changeScreen(
                          context: context, widget: AdminHomePage()),
                      title: "Search By AadharCard",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(),
                    CategoryCard(
                      assetImage: "assets/statistic.jfif",
                      onTap: () => changeScreen(
                        context: context,
                        widget: StatisticsPage(),
                      ),
                      title: "Statistics",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
