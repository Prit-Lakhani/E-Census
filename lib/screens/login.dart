import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_census_2021/constants/colors.dart';
import 'package:e_census_2021/constants/config.dart';
import 'package:e_census_2021/screens/admin/admin_main_page.dart';
import 'package:e_census_2021/screens/admin_home.dart';
import 'package:e_census_2021/screens/enumerator/enumerator_menu.dart';
import 'package:e_census_2021/widgets/custom_textfiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isTermsAndConditionAccepted = false;
  final TextEditingController _passwordController = TextEditingController();
  double _height;
  double _width;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: InkWell(
        onTap: () async {
          if (_formKey.currentState.validate()) {
            print("SignIn With EmailAndPassword calling...");
            _signInWithEmailAndPassword();
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
            child: Center(
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      textEditingController: _emailController,
      keyboardType: TextInputType.emailAddress,
      prefix: false,
      validator: emailValidator,
      icon: Icons.email,
      hint: "Enter Your  Email Address",
    );
  }

  Widget passwordTextFormField() {
    return CustomTextField(
      textEditingController: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      prefix: false,
      validator: pwdValidator,
      icon: Icons.visibility,
      hint: "Enter Your Password",
    );
  }

  @override
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 18.0),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: _width / 20,
                                          top: _height / 100),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Login To Continue",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   alignment: Alignment.centerLeft,
                                  //   margin:
                                  //       EdgeInsets.only(left: _width / 15.0),
                                  //   child: Row(
                                  //     children: <Widget>[
                                  //       Text(
                                  //         "Login To Continue",
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.w200,
                                  //           fontSize: 17,
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
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
                                      emailTextFormField(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      passwordTextFormField(),
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

  void _signInWithEmailAndPassword() {
    //  String errorMessage;
    try {
      _auth
          .signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          )
          .then((currentUser) => _firestore
              .collection("users")
              .doc(currentUser.user.uid)
              .get()
              .then((DocumentSnapshot result) {
                print("result found...");
                if (result.exists && result['role'] == "enumerator") {
                  showToast("yah, you are admin...", context);
                  // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  //   return UserFormStatus();
                  // }));
                  changeScreen(context: context, widget: EnumeratorMenuPage());
                } else if (result.exists && result['role'] == "admin") {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return AdminMainPage();
                  }));
                } else {
                  showToast("document does not exist in database", context);
                }
              })
              .catchError((err) => print("then " + err))
              .catchError((err) => print("error " + err)));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast('No user found for that email.', context);
      } else if (e.code == 'wrong-password') {
        showToast('Wrong password provided for that user.', context);
      } else {
        showToast('something went to wrong', context);
      }
    } catch (e) {
      print(e);
    }
  }

  // _auth.authStateChanges()
  // .listen((User user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });

  void _signOut() async {
    await _auth.signOut();
  }
}
