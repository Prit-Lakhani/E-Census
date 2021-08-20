import 'package:e_census_2021/constants/colors.dart';
import 'package:e_census_2021/constants/config.dart';
import 'package:e_census_2021/provider/auth.dart';
import 'package:e_census_2021/screens/self/self_authentication/numeric_pad.dart';
import 'package:e_census_2021/screens/self/self_homepage.dart';
import 'package:e_census_2021/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyPhone extends StatefulWidget {
  final String phoneNumber;
  final String aadharNumber;
  VerifyPhone({@required this.phoneNumber, @required this.aadharNumber});

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Verify phone",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
      ),
      body: SafeArea(
        child:
            Consumer(builder: (context, AuthProvider provider, Widget child) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Text(
                              "Code is sent to " + widget.phoneNumber,
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xFF818181),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                buildCodeNumberBox(code.length > 0
                                    ? code.substring(0, 1)
                                    : ""),
                                buildCodeNumberBox(code.length > 1
                                    ? code.substring(1, 2)
                                    : ""),
                                buildCodeNumberBox(code.length > 2
                                    ? code.substring(2, 3)
                                    : ""),
                                buildCodeNumberBox(code.length > 3
                                    ? code.substring(3, 4)
                                    : ""),
                                buildCodeNumberBox(code.length > 4
                                    ? code.substring(4, 5)
                                    : ""),
                                buildCodeNumberBox(code.length > 5
                                    ? code.substring(5, 6)
                                    : ""),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Didn't recieve code? ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF818181),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showToast(
                                        "Otp resend function comming soon",
                                        context);
                                  },
                                  child: Text(
                                    "Request again",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (code.length == 6) {
                                  provider.otpVerify(
                                    context: context,
                                    smsOTP: code,

                                    // userDataModel: widget.user,
                                    widget: SelfHomePage(
                                        aadharNumber: widget.aadharNumber),
                                  );
                                } else {
                                  showToast('OTP must be 6 digit', context);
                                }
                                // Navigator.push(a3
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => HomePage()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: kPrimaryGradient,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Verify and Create Account",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
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
                  NumericPad(
                    onNumberSelected: (value) {
                      print(value);
                      setState(() {
                        if (value != -1) {
                          if (code.length < 6) {
                            code = code + value.toString();
                          }
                        } else {
                          code = code.substring(0, code.length - 1);
                        }
                        print(code);
                      });
                    },
                  ),
                ],
              ),
              // provider.loading == false
              //     ? SizedBox.shrink()
              //     : Container(
              //         child: Center(child: CircularProgressIndicator()),
              //       )
            ],
          );
        }),
      ),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
