import 'package:e_census_2021/services/user_backend_io.dart';
import 'package:flutter/material.dart';
import 'package:e_census_2021/constants/config.dart';

class UserDetailsPage extends StatefulWidget {
  int aadharNo;
  bool p1Status, p2Status;
  UserDetailsPage(
      {Key key,
      @required this.aadharNo,
      @required this.p1Status,
      @required this.p2Status})
      : super(key: key);
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  var userPhase1Data, userPhase2Data;

  @override
  void initState() {
    super.initState();
    widget.p1Status ? getPhase1Data() : null;
    widget.p2Status ? getPhase2Data() : null;
  }

  Future<void> getPhase1Data() async {
    print("COME IN GET PHASE1 DATA METHOD");
    try {
      var res = await HandleUserData.getUserPhase1Data(
          aadhar: widget.aadharNo.toString());
      print(res);
      if (res.exists) {
        // print("Exists..." + res.data().toString());
        userPhase1Data = res.data();

        print("userPhase1Data Exists..." + userPhase1Data.toString());
        P1Data.creatDataTableRow(userPhase1Data);
        setState(() {});
      }
    } catch (e) {
      print("Exception");
    }
  }

  Future<void> getPhase2Data() async {
    print("COME IN GET PHASE2 DATA METHOD");
    try {
      var response = await HandleUserData.isChildAadhar(
          aadhar: widget.aadharNo.toString());
      // print(res);
      if (response != null) {
        try {
          var res = await HandleUserData.getUserPhase2Data(
              aadhar: response['parent_aadhar'].toString());
          print(res);
          // print("Exists..." + res.data().toString());
          userPhase2Data = res.data();

          print("userPhase2Data Exists..." + userPhase2Data.toString());
          P2Data.creatDataTableRow(userPhase2Data);
          setState(() {});
        } catch (e) {}
      } else {
        print("COME IN ELSE PART");
        var res = await HandleUserData.getUserPhase2Data(
            aadhar: widget.aadharNo.toString());
        print(res);
        // print("Exists..." + res.data().toString());
        userPhase2Data = res.data();

        print("userPhase2Data Exists..." + userPhase2Data.toString());
        P2Data.creatDataTableRow(userPhase2Data);
        setState(() {});
      }
    } catch (e) {
      print("Exception");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff90e0ef),
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => {}),
        title: Text(
          "User Details",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.details,
                color: Colors.black87,
              ),
              onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 60.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xff5a348b),
                    gradient: LinearGradient(
                        colors: [Color(0xff8d70fe), Color(0xff2da9ef)],
                        begin: Alignment.centerRight,
                        end: Alignment(-1.0, -1.0)), //Gradient
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        Text(
                          'Phase-1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        widget.p1Status
                            ? SizedBox(
                                height: 15,
                              )
                            : Container(),
                        widget.p1Status
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height - 161.0,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'Field',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text('Value',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat')),
                                      ),
                                    ],
                                    rows: P1Data.names
                                        .map((name) => DataRow(cells: [
                                              DataCell(Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Text(
                                                  name.field,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600,
                                                    // fontSize: 10
                                                  ),
                                                ),
                                              )),
                                              DataCell(Text(
                                                name.value,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                            ]))
                                        .toList(),
                                  ),
                                ),
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height - 158.0,
                                child: Center(
                                  child: SizedBox(
                                    height: 200,
                                    width: 250,
                                    child: Card(
                                      //color: Colors.grey[100],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      elevation: 8,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Oops!",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Phase 1 Data not found!",
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(height: 7),
                                            Icon(
                                              Icons.face,
                                              color: Colors.black54,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xff5a348b),
                    gradient: LinearGradient(
                        colors: [Color(0xffebac38), Color(0xffde4d2a)],
                        begin: Alignment.centerRight,
                        end: Alignment(-1.0, -1.0)), //Gradient
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Column(
                      children: [
                        Text(
                          'Phase-2',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        widget.p2Status
                            ? SizedBox(
                                height: 15,
                              )
                            : Container(),
                        widget.p2Status
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height - 158.0,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          'Field',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text('Value',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat')),
                                      ),
                                    ],
                                    rows: P2Data.names
                                        .map((name) => DataRow(cells: [
                                              DataCell(Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Text(
                                                  name.field,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600,
                                                    // fontSize: 10
                                                  ),
                                                ),
                                              )),
                                              DataCell(Text(
                                                name.value,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                            ]))
                                        .toList(),
                                  ),
                                ),
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height - 158.0,
                                child: Center(
                                  child: SizedBox(
                                    height: 200,
                                    width: 250,
                                    child: Card(
                                      //color: Colors.grey[100],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      elevation: 8,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Oops!",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Phase 2 Data not found!",
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(height: 7),
                                            Icon(
                                              Icons.face,
                                              color: Colors.black54,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
