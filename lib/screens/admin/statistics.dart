import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_census_2021/services/user_backend_io.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int totalNumberWithoutAadharCard = 0;
  int totalNumberWithAadharCard = 0;
  int totalNumberSelfUser = 0;
  int notSpecified = 0;
  int totalMale = 0;
  int totalFemale = 0;
  List<String> cast = [];
  int totalAge0to30 = 0;
  int totalAge30to50 = 0;
  int totalAge50above = 0;
  List<String> religion = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPeopleData();
  }

  void getPeopleData() async {
    int totalCountMale = 0;
    int totalCountFemale = 0;
    int totalCounOther = 0;
    int totalCountAge0to30 = 0;
    int totalCountAge30to50 = 0;
    int totalCountAge50above = 0;
    QuerySnapshot peopleData =
        await FirebaseFirestore.instance.collection("people").get();
    peopleData.docs.forEach(
      (element2) async {
        element2['isWithAadharCard']
            ? totalNumberWithAadharCard++
            : element2['isSelfUser']
                ? totalNumberSelfUser++
                : element2['isWithoutAadharCard']
                    ? totalNumberWithoutAadharCard++
                    : notSpecified++;

        await FirebaseFirestore.instance
            .collection("people")
            .doc(element2.id)
            .collection("phase1")
            .doc(element2.id)
            .get()
            .then(
              (element) => {
                print(totalCountMale),
                element['sexType'] == "Male"
                    ? totalCountMale++
                    : totalCountFemale++,
                if (element['sexType'] == "Transgender")
                  {
                    totalCounOther++,
                  },
                cast.add(
                  element['cast'].toString(),
                ),
                element['age'] < 30
                    ? totalCountAge0to30++
                    : element['age'] > 50
                        ? totalCountAge50above++
                        : totalCountAge30to50++,
                religion.add(
                  element['religion'].toString(),
                ),
                setState(() {
                  totalFemale = totalCountFemale;
                  print("totalFemale $totalFemale");
                  totalMale = totalCountMale;
                  notSpecified = totalCounOther;
                  totalAge0to30 = totalCountAge0to30;
                  totalAge30to50 = totalCountAge30to50;
                  totalAge50above = totalCountAge50above;
                  //  loading = false;
                }),
              },
            );
      },
    );

    setState(() {
      totalFemale = totalCountFemale;
      print("totalFemale $totalFemale");
      totalMale = totalCountMale;
      notSpecified = totalCounOther;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(totalMale);
    print(totalFemale);
    final List<ChartData> sexTypeChartData = [
      ChartData(
        "Male",
        double.parse(totalMale.toString()),
      ),
      ChartData(
        "Female",
        double.parse(totalFemale.toString()),
      ),
      ChartData(
        "Not Specified",
        double.parse(notSpecified.toString()),
      ),
    ];
 final List<ChartData> ageTypeChartData = [
      ChartData(
                  "Age 0-30",

        double.parse(totalAge0to30.toString()),
      ),
      ChartData(
                 "Age 30-50",

        double.parse(totalAge30to50.toString()),
      ),
      ChartData(
                 "Age 50 above",

        double.parse(totalAge50above.toString()),
      ),
    ];
    final List<ChartData> chartData = [
      ChartData(
        'With AadharCard',
        double.parse(
          totalNumberWithAadharCard.toString(),
        ),
      ),
      ChartData(
        'Without AadharCard',
        double.parse(
          totalNumberWithoutAadharCard.toString(),
        ),
      ),
      ChartData(
        'Self User',
        double.parse(
          totalNumberSelfUser.toString(),
        ),
      ),
    ];

    return Scaffold(
      body: loading == false
          ? SafeArea(
              child: SingleChildScrollView(
                              child: Column(
                  children: [
                    Container(
                      child: SfCircularChart(
                        series: <CircularSeries>[
                          // Render pie chart
                          PieSeries<ChartData, String>(
                              dataSource: chartData,
                              pointColorMapper: (ChartData data, _) => data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              explode: true,
                              explodeIndex: 1,
                              enableSmartLabels: true,
                              dataLabelSettings: DataLabelSettings(
                                  // Renders the data label
                                  labelPosition: ChartDataLabelPosition.inside,
                                  isVisible: true)),
                        ],
                        title: ChartTitle(text: "Total Aadhar Data"),
                        legend: Legend(isVisible: true),
                      ),
                    ),
                    Container(
                      child: SfCircularChart(
                        series: <CircularSeries>[
                          // Render pie chart
                          PieSeries<ChartData, String>(
                              dataSource: sexTypeChartData,
                              pointColorMapper: (ChartData data, _) => data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              explode: true,
                              explodeIndex: 1,
                              enableSmartLabels: true,
                              dataLabelSettings: DataLabelSettings(
                                  // Renders the data label
                                  labelPosition: ChartDataLabelPosition.inside,
                                  isVisible: true)),
                        ],
                        title: ChartTitle(text: "Male/Female Data Comparision"),
                        legend: Legend(isVisible: true),
                      ),
                    ),
                     Container(
                      child: SfCircularChart(
                        series: <CircularSeries>[
                          // Render pie chart
                          PieSeries<ChartData, String>(
                              dataSource: ageTypeChartData,
                              pointColorMapper: (ChartData data, _) => data.color,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              explode: true,
                              explodeIndex: 1,
                              enableSmartLabels: true,
                              dataLabelSettings: DataLabelSettings(
                                  // Renders the data label
                                  labelPosition: ChartDataLabelPosition.inside,
                                  isVisible: true)),
                        ],
                        title: ChartTitle(text: "Age Wise Data Comparision"),
                        legend: Legend(isVisible: true),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : CircularProgressIndicator(),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
