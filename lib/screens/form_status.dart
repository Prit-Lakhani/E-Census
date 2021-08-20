import 'package:e_census_2021/constants/colors.dart';
import 'package:e_census_2021/screens/phase1_form.dart';
import 'package:e_census_2021/screens/phase2_form.dart';
import 'package:e_census_2021/services/user_backend_io.dart';
import 'package:e_census_2021/widgets/common_widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_census_2021/constants/config.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UserFormStatus extends StatefulWidget {
  UserFormStatus({Key key}) : super(key: key);

  @override
  _UserFormStatusState createState() => _UserFormStatusState();
}

class _UserFormStatusState extends State<UserFormStatus> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var data;
  bool p1Status, p2Status, status, dataNotFound, isPressSearch;
  int aadharNo;
  int memberAadharNumberLength;
  String errorMsg = "";
  MediaQueryData mData;
  double totalWidthPixel;
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    User.familyAadharController = TextEditingController();
    User.userAadharController.clear();
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

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: new BoxDecoration(
                  color: kSecondaryBackgroundColor,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text(
                                "--- E-Census-2021 ---",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Add Family Members Details',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mData.size.height / 1.88,
                      child: Container(
                        //   margin: EdgeInsets.only(
                        //       top: mData.size.height * 0.2),
                        //  padding: EdgeInsets.only(top: 10),
                        height: 300,
                        width: mData.size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            LoginScreenTextField(
                              icon: Icon(
                                Icons.confirmation_number,
                                color: Colors.grey,
                                size: 25,
                              ),
                              hint: 'Aadhar Number',
                              textEditingController:
                                  User.familyAadharController,
                              input: TextInputType.number,
                              onChanged: (value) {
                                aadharNo = int.parse(value);
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RawMaterialButton(
                              onPressed: () async {
                                try {
                                  setState(() {
                                    pr.show();
                                  });

                                  print("AADHAR VALID");
                                  var res = await HandleUserData
                                      .familyAadharAlreadyLinkedOrNot(
                                    childAadhar:
                                        User.familyAadharController.text,
                                  );
                                  if (res == "false") {
                                    try {
                                      var res = await HandleUserData
                                          .linkFamilyAadharToParent(
                                              childAadhar: User
                                                  .familyAadharController.text,
                                              parentAadhar: User
                                                  .userAadharController.text);
                                      if (res == 'done') {
                                        print("LINKED FAMILY AADHAR TO PARENT");
                                        var resp = await HandleUserData
                                            .linkParentAadharToFamilyMember(
                                                childAadhar: User
                                                    .familyAadharController
                                                    .text,
                                                parentAadhar: User
                                                    .userAadharController.text);
                                        if (resp == "done") {
                                          print(
                                              "LINKED PARENT AADHAR TO FAMILY");

                                          var respo = await HandleUserData
                                              .phase2TrueInFamilyMember(
                                            childAadhar: User
                                                .familyAadharController.text,
                                          );
                                          if (respo == 'done') {
                                            setState(() {
                                              pr.hide();
                                            });
                                            messageAllert(
                                                "Child Aadhar Successfully added",
                                                'Success');
                                            print("Phase-2 Status true...");
                                          }
                                        }
                                      }
                                    } catch (e) {}
                                  } else {
                                    setState(() {
                                      pr.hide();
                                    });

                                    print("Aadhar linked already...");
                                    messageAllert(
                                        "This Aadhar already linked with other parent!",
                                        'Oops!');
                                  }
                                } catch (e) {
                                  print("EXCEPTION");
                                }
                              }, //do your action
                              elevation: 5.0,
                              constraints:
                                  BoxConstraints(), //removes empty spaces around of icon
                              shape: CircleBorder(), //circular button
                              fillColor: Colors.orange, //background color
                              splashColor: Colors.amber,
                              highlightColor: Colors.amber,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 28,
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.orange[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  elevation: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 23.0,
                                        bottom: 5,
                                        right: 8,
                                        left: 8),
                                    child: ListView.builder(
                                      itemCount: memberAadharNumberLength,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15, bottom: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // shrinkWrap: true,
                                            // scrollDirection:
                                            // Axis.vertical,
                                            children: [
                                              Text(
                                                data['family_aadhar'][index]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54),
                                              ),
                                              Divider(
                                                height: 15,
                                                thickness: 1,
                                                color: Colors.black26,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                            "Enter the people's Aadhar number :",
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
                            hint: 'Aadhar Number',
                            textEditingController: User.userAadharController,
                            input: TextInputType.number,
                            onChanged: (value) {
                              aadharNo = int.parse(value);
                            },
                          ),
                          SizedBox(height: 5),
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
                                if (User.userAadharController.text.length ==
                                    12) {
                                  print("AADHAR VALID");

                                  data = await HandleUserData.getFormStatus(
                                    aadharNo: User.userAadharController.text,
                                  );
                                  if (data != null) {
                                    bool p1Stat;
                                    // print("P1 Status: " +
                                    //     data['p1_status'].toString());
                                    try {
                                      print("FAMILY AADHAR NUMBERS: " +
                                          data['family_aadhar'].toString());
                                    } catch (e) {
                                      print(
                                          "EXCEPTION family_aadhar field not found...");
                                    }
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
                                      try {
                                        memberAadharNumberLength =
                                            data['family_aadhar'].length;
                                        print("LENGTH OF Aadhar: " +
                                            memberAadharNumberLength
                                                .toString());
                                      } catch (e) {
                                        print(
                                            "EXCEPTION family_aadhar field not found... and set lenght = 0");
                                        memberAadharNumberLength = 0;
                                      }
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
                                  setState(() {
                                    dataNotFound = true;
                                    p1Status = false;
                                    p2Status = false;
                                    status = true;
                                    isPressSearch = false;
                                    errorMsg =
                                        "Aadhar Number must be 12 digits!";
                                  });
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
                          SizedBox(
                            height: 30,
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
                                    isPressSearch
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Phase1Form(
                                                      status: p1Status,
                                                      aadharNo: aadharNo,
                                                      isSelfUser: false,
                                                      isWithAadharCard: true,
                                                      isWithoutAadharCard:
                                                          false,
                                                      // int.parse(User
                                                      //     .userAadharController.text),
                                                    )))
                                        : null;
                                    // User.userAadharController.clear();
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
                                    isPressSearch
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Phase2Form(
                                                      isSelfUser: false,
                                                      isWithAadharCard: true,
                                                      isWithoutAadharCard:
                                                          false,
                                                      aadharNo: aadharNo,
                                                    )))
                                        : null;
                                    User.userAadharController.clear();
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
                                        color: p2Status
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
      floatingActionButton: showFab
          ? FloatingActionButton(
              onPressed: () {
                p2Status
                    ? bottomSheet()
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new CupertinoAlertDialog(
                            title: Text("Alert"),
                            content: Text(
                              "After Completing Phase-2 Form, Census can add thier family members Details.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
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
              },
              child: Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
