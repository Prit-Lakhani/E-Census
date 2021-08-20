import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_census_2021/screens/admin_form_phase_screen.dart';
import 'package:e_census_2021/services/user_backend_io.dart';
import 'package:flutter/material.dart';

class DataList extends StatelessWidget {
  final String widgetCallFrom;
  DataList({
    @required this.widgetCallFrom,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Census"),
      ),
      body: FutureBuilder(
        builder: (BuildContext context,
            AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return CircularProgressIndicator();
          }
          if (widgetCallFrom == "withAadharCard") {
//  'isWithAadharCard': isWithAadharCard,
//             'isWithoutAadharCard': isWithoutAadharCard,
//             'isSelfUser': isSelfUser
            List<QueryDocumentSnapshot> withAadharDataList = [];

            snapshot.data.forEach(
              (element) {
                if (element.data()['isWithAadharCard']) {
                  withAadharDataList.add(element);
                  print(element.id);
                }
              },
            );
            return ListView.builder(
              itemCount: withAadharDataList.length,
              itemBuilder: (BuildContext context, int index) {
                print(withAadharDataList.length);
                return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetailsPage(
                                  aadharNo:
                                      int.parse(withAadharDataList[index].id),
                                  p2Status: true,
                                  p1Status: true,
                                  // int.parse(User
                                  //     .userAadharController.text),
                                ))),
                    child: Card(
                        elevation: 2,
                        child: ListTile(
                            title: Text(
                                "aadhar No. :- ${withAadharDataList[index].id}"))));
              },
            );
          } else if (widgetCallFrom == "withoutAadharCard") {
            List<QueryDocumentSnapshot> withoutAadharDataList = [];

            snapshot.data.forEach(
              (element) {
                if (element.data()['isWithoutAadharCard']) {
                  withoutAadharDataList.add(element);
                  print(element.id);
                }
              },
            );

            return ListView.builder(
              itemCount: withoutAadharDataList.length,
              itemBuilder: (BuildContext context, int index) {
                print(withoutAadharDataList.length);
                return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetailsPage(
                                  aadharNo: int.parse(
                                      withoutAadharDataList[index].id),
                                  p2Status: true,
                                  p1Status: true,
                                  // int.parse(User
                                  //     .userAadharController.text),
                                ))),
                    child: Card(
                        elevation: 2,
                        child: ListTile(
                            title: Text(
                                "Id No. :- ${withoutAadharDataList[index].id}"))));
              },
            );
          } else if (widgetCallFrom == "selfUser") {
            List<QueryDocumentSnapshot> selfUserDataList = [];

            snapshot.data.forEach(
              (element) {
                if (element.data()['isSelfUser']) {
                  selfUserDataList.add(element);
                  print(element.id);
                }
              },
            );

            return ListView.builder(
              itemCount: selfUserDataList.length,
              itemBuilder: (BuildContext context, int index) {
                print(selfUserDataList.length);
                return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetailsPage(
                                  aadharNo:
                                      int.parse(selfUserDataList[index].id),
                                  p2Status: true,
                                  p1Status: true,
                                  // int.parse(User
                                  //     .userAadharController.text),
                                ))),
                    child: Card(
                        elevation: 2,
                        child: ListTile(
                            title: Text(
                                "Self User aadhar No. :- ${selfUserDataList[index].id}"))));
              },
            );
          }
        },
        future: HandleUserData.getPeopleData(),
      ),
    );
  }
}
