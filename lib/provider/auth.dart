import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_census_2021/constants/config.dart';
import 'package:e_census_2021/models/usermodel.dart';
import 'package:e_census_2021/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;
  String collection = "self-users";
  String errorMessage;
  UserDataModel userDataModel = UserDataModel();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createUser(UserDataModel userDataModel) {
    String id = userDataModel.aadharNumber.toString();
    print(id);
    _firestore
        .collection(collection)
        .doc(id)
        .set(userDataModel.toMap(userDataModel));
  }

  void updateUserData(Map<String, dynamic> values) {
    _firestore.collection(collection).doc(values['number']).update(values);
  }

  Future<DocumentSnapshot> getUserById(String id) =>
      _firestore.collection("aadhar-data").doc(id).get().then((doc) {
        if (!doc.exists) {
          return null;
        }
        return doc;
      }).catchError((onError) => print(onError.toString()));
  Future<void> otpVerify({
    BuildContext context,
    Widget widget,
    //  UserDataModel userDataModel,
    String smsOTP,
  }) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      _auth.signInWithCredential(credential).then((user) async {
        print(user);
        if (user.user != null) {
          print(userDataModel.mobileNumber.toString());

          if (userDataModel != null) {
            notifyListeners();
            print("userDataModel in auth.dart" + userDataModel.name.toString());
            createUser(userDataModel);
            print(userDataModel.mobileNumber.toString() + "mobileNUmber");
            showToast('SUCCESS3', context);
            print(user.user.phoneNumber);
            notifyListeners();
            changeScreenReplacement(context, widget);
          } else {
            print(user);

            showToast('SUCCESS4', context);

            print(user.user.phoneNumber);
            changeScreenReplacement(context, widget);
          }
        } else {
          showToast('You Enter Invalid OTP', context);
        }
      }).catchError((e) {
        print(e);
        showToast('You Enter Invalid Otp', context);
      });
    } catch (e) {
      print("${e.toString()}");
    }
  }

  Future<void> verifyPhoneNumber(
      {BuildContext context,
      String number,
      Widget widget,
      Widget afterOtpWidget}) async {
    //on Otp send this function will call
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      print("smsOTPSent={smsOTPSent}");
      print(verId);
      print("fjnsdjjngjn${number}");
      this.verificationId = verId;
      notifyListeners();
      changeScreen(
        context: context,
        widget: widget,
      );
    };

//after verfication complete this function will call
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {
        if (value.user != null) {
          // Handle loogged in state
          if (userDataModel != null) {
            createUser(userDataModel);

            print(userDataModel.mobileNumber.toString() + "mobileNUmber");
            print(userDataModel);

            showToast('SUCCESS1', context);

            print(value.user.phoneNumber);
            changeScreenReplacement(context, afterOtpWidget);
          } else {
            print(value);

            showToast('SUCCESS2', context);

            print(value.user.phoneNumber);
            changeScreenReplacement(context, afterOtpWidget);
          }
          print(value.user.phoneNumber);
        } else {
          showToast("Error validating OTP, try again", context);
        }
      }).catchError((error) {
        showToast("Try again in sometime", context);
      });
    };

    print(smsOTPSent);
    print("fjnsdjjngjn${number}");

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+91 ${number}', // PHONE NUMBER TO SEND OTP

          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
            notifyListeners();
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: (FirebaseAuthException exceptio) {
            print('${exceptio.message} + something is wrong');
          });
    } catch (e) {
      handleError(e, context);
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  handleError(error, BuildContext context) {
    print(error);
    errorMessage = error.toString();
    notifyListeners();
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        print("The verification code is invalid");
        break;
      default:
        errorMessage = error.message;
        break;
    }
  }

  notifyListeners();
  Future signOut() async {
    _auth.signOut();
    // _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
