import 'package:e_census_2021/constants/colors.dart';
import 'package:e_census_2021/constants/config.dart';
import 'package:e_census_2021/screens/phase1_form.dart';
import 'package:e_census_2021/screens/phase2_form.dart';
import 'package:e_census_2021/services/user_backend_io.dart';
import 'package:e_census_2021/widgets/common_widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class EnumeratorHomePage extends StatefulWidget {
  @override
  _EnumeratorHomePageState createState() => _EnumeratorHomePageState();
}

class _EnumeratorHomePageState extends State<EnumeratorHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var data;
  bool p1Status, p2Status, status, dataNotFound, isPressSearch;
  int aadharNo;
  int memberAadharNumberLength;
  String errorMsg = "";
  MediaQueryData mData;
  double totalWidthPixel;
  ProgressDialog pr;
  TextEditingController _generatedID = TextEditingController();

  @override
  void initState() {
    super.initState();
    // User.familyAadharController = TextEditingController();
    // onStart(aadharNo: widget.aadharNumber);
    // generatedID = Uuid().v4();

    p1Status = false;
    p2Status = false;
    status = true;
    dataNotFound = false;
    isPressSearch = false;
  }

  messageAllert(String msg, String ttl) {
    // Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(ttl),
            content: Text(msg),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Okay'),
                  ],
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    mData = MediaQuery.of(context);
    totalWidthPixel = mData.size.width * mData.devicePixelRatio;
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          color: kLoginBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.blue[50],
                  elevation: 10,
                  child: Container(
                    // color: Colors.blue[100],
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Enter Your Generated Number :",
                            style: TextStyle(
                                color: Colors.blue[800],
                                // fontFamily: 'Montserrat',
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          LoginScreenTextField(
                            icon: Icon(
                              Icons.account_circle,
                              color: Colors.grey,
                              size: 25,
                            ),
                            hint: 'Enter Your Generated ID',
                            textEditingController: _generatedID,
                            input: TextInputType.text,
                            onChanged: (value) {
                              aadharNo = int.parse(value);
                            },
                          ),
                          dataNotFound
                              ? Text(
                                  errorMsg,
                                  style: TextStyle(
                                      color: Colors.red,
                                      // fontFamily: 'Montserrat',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          RaisedButton(
                            elevation: 2,
                            padding: EdgeInsets.only(
                                top: 8, bottom: 8, right: 35, left: 35),
                            onPressed: () async {
                              try {
                                if (_generatedID.text != null &&
                                    _generatedID.text.length == 10) {
                                  print("AADHAR VALID");

                                  data = await HandleUserData.getFormStatus(
                                      aadharNo: _generatedID.text);
                                  if (data != null) {
                                    bool p1Stat;
                                    // print("P1 Status: " +
                                    //     data['p1_status'].toString());

                                    try {
                                      p1Stat = data['p1_status'];
                                    } catch (StateError) {
                                      print(
                                          "p1 status not found... set p1 status = false");
                                      p1Stat = false;
                                    }

                                    setState(() {
                                      p1Status = p1Stat;
                                      p2Status = data['p2_status'];
                                      isPressSearch = true;

                                      status = false;
                                      dataNotFound = false;
                                    });
                                  } else {
                                    print("COME IN ELSE... Data null");
                                    setState(() {
                                      p1Status = false;
                                      p2Status = false;
                                      status = false; //true;
                                      dataNotFound = false; //true;
                                      isPressSearch = true; //false;
                                      // errorMsg = "Data not found";
                                    });
                                  }
                                } else {
                                  // setState(() {
                                  //   pr.hide();
                                  // });

                                  print("AADHAR NOT VALID.../");
                                  messageAllert(
                                      "Entered ID is Empty or 10 character Less !",
                                      'Alert!');
                                }
                              } catch (StateError) {
                                print("COME INTO STATEERROR...");
                                setState(() {
                                  memberAadharNumberLength = 0;
                                });
                              }
                            },
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Text(
                              'Search',
                              style: TextStyle(
                                  color: Colors.white,
                                  // fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RaisedButton(
                                  elevation: 2,
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, right: 25, left: 25),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Phase1Form(
                                                  aadharNo: 123,
                                                  status: p1Status,
                                                  generatedId:
                                                      _generatedID.text,
                                                  isSelfUser: false,
                                                  isWithAadharCard: false,
                                                  isWithoutAadharCard: true,
                                                  // int.parse(User
                                                  //     .userAadharController.text),
                                                )));
                                  },
                                  color: Colors.pink[50],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Text(
                                    'Phase 1',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        // fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                !status
                                    ? Icon(
                                        p1Status ? Icons.done : Icons.close,
                                        size: 30,
                                        color: p1Status
                                            ? Colors.green
                                            : Colors.red,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Row(
                              children: [
                                RaisedButton(
                                  elevation: 2,
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, right: 25, left: 25),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Phase2Form(
                                                aadharNo: 123,
                                                isSelfUser: false,
                                                isWithAadharCard: false,
                                                isWithoutAadharCard: true,
                                                generatedId:
                                                    _generatedID.text)));
                                  },
                                  color: Colors.pink[50],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Text(
                                    'Phase 2',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        // fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                !status
                                    ? Icon(
                                        p2Status ? Icons.done : Icons.close,
                                        size: 30,
                                        color: p1Status
                                            ? Colors.green
                                            : Colors.red,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
