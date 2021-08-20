import 'package:e_census_2021/constants/colors.dart';
import 'package:e_census_2021/constants/config.dart';
import 'package:e_census_2021/provider/auth.dart';
import 'package:e_census_2021/screens/self/self_authentication/otpscreen.dart';
import 'package:e_census_2021/screens/self/self_homepage.dart';
import 'package:e_census_2021/services/auth_service.dart';
import 'package:e_census_2021/services/database_service.dart';
import 'package:e_census_2021/widgets/custom_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  double _height;
  double _width;
  bool isSignInModeOn = true;
  bool isTermsAndConditionAccepted = false;

  TextEditingController aadharNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _height = SizeConfig.screenHeight;
    _width = SizeConfig.screenWidth;
    return Scaffold(
      body: Material(
        child: Container(
          height: _height,
          width: _width,
          // color: kBlue,
          decoration: BoxDecoration(gradient: kPrimaryGradient),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: _height * 0.65,
              width: _width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Container(
                  height: _height * 0.65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: _width / 20, top: _height / 100),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Signin For Self",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin:
                                        EdgeInsets.only(left: _width / 15.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Login To Continue",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: _width / 12.0,
                                  right: _width / 12.0,
                                ),
                                child: Form(
                                  key: _formKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      phoneTextFormField(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(child: acceptTermsTextRow()),
                          Column(
                            children: [
                              loginButton(),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: InkWell(
        onTap: () {
          if (aadharNumberController.text.length != 12) {
            showToast("Enter Valid Aadhar Number", context);
          } else {
            Provider.of<AuthProvider>(context, listen: false)
                .getUserById(aadharNumberController.text.trim())
                .then(
              (user) async {
                if (user == null) {
                  showToast(
                      "Entered Aadhar Number is not in our database", context);
                } else {
                  print("===Aadharcard Number===" +
                      aadharNumberController.text.trim().toString());
                  String mobileNumber = await DatabaseService()
                      .fetchMobileNumber(
                          aadharNumberController.text.trim().toString());
                  Provider.of<AuthProvider>(context, listen: false)
                      .verifyPhoneNumber(
                    context: context,
                    number: mobileNumber,
                    widget: VerifyPhone(
                      phoneNumber: mobileNumber,
                      aadharNumber:
                          aadharNumberController.text.trim().toString(),
                    ),
                    afterOtpWidget: SelfHomePage(
                        aadharNumber:
                            aadharNumberController.text.trim().toString()),
                  );
                }
              },
            );
          }
        },
        //onTap: () => changeScreen(context, MainPage()),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              gradient: kPrimaryGradient,
            ),
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Enter  In Self Section",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  // Widget screenRoute(TextEditingController controller) {
  //   _userServicse.getUserById(controller.text).then((value) {
  //     if (value.exists) {
  //       print(value["role"]);
  //       if (value["role"] == "admin") {
  //         return AdminHomePage();
  //       } else {
  //         return HomePage();
  //       }
  //     }
  //   });
  // }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: kSecondaryBackgroundColor,
              value: isTermsAndConditionAccepted,
              onChanged: (bool newValue) {
                setState(() {
                  isTermsAndConditionAccepted = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      textEditingController: aadharNumberController,
      keyboardType: TextInputType.number,
      prefix: false,
      validator: validateMobile,
      icon: Icons.verified_user,
      hint: "Enter Your Adhar Number",
    );
  }
}
