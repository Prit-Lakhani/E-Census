import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import firebase from 'firebase/app';

class HandleUserData {
  static Future<List<QueryDocumentSnapshot>> getPeopleData() async {
    var data = await FirebaseFirestore.instance.collection('people').get();
    return data.docs;
  }

  static Future<DocumentSnapshot> getFormStatus({
    @required String aadharNo,
  }) async {
    print("COME IN GET FORM STATUS...");
//     DocumentSnapshot formStatus = await FirebaseFirestore.instance.collection('aadhar_form_status').doc(aadharNo.toString()).get();
//      if (formStatus.exists) {
//         print('success');
//         print(formStatus.data['a']);
//         print(formStatus.data['p1_status']);
//       print(querySnapshot.data['lname']);
//      }

//  // formStatus.data['p1_form'];
//    print(formStatus.toString());
    // if (aadharNo == null) {
    //   var res = FirebaseFirestore.instance
    //       .collection('without_aadhar_form_status')
    //       .doc(aadharNo.toString())
    //       .get()
    //       .then((DocumentSnapshot result) async {
    //     if (result.exists) {
    //       // print(result['p1_status'].toString());
    //       return result;
    //     } else {
    //       print("document does not exist in database");

    //       await FirebaseFirestore.instance
    //           .collection("without_aadhar_form_status")
    //           .doc(aadharNo.toString())
    //           .set({
    //         'p1_status': false,
    //         'p2_status': false,
    //       });
    //       print("added form-status in db...");
    //       return null;
    //     }
    //   }).catchError((err) => print("then " + err.toString()));

    //   return res;
    // } else {
    var res = FirebaseFirestore.instance
        .collection('aadhar_form_status')
        .doc(aadharNo.toString())
        .get()
        .then((DocumentSnapshot result) async {
      if (result.exists) {
        // print(result['p1_status'].toString());
        return result;
      } else {
        print("document does not exist in database");

        await FirebaseFirestore.instance
            .collection("aadhar_form_status")
            .doc(aadharNo.toString())
            .set({
          'p1_status': false,
          'p2_status': false,
        });
        print("added form-status in db...");
        return null;
      }
    }).catchError((err) => print("then " + err.toString()));

    return res;
    // }
  }

  // static Future<String> checkAdharValidOrNot({String aadhar}) async {
  //   String response = " ";
  //   print("Aadhar: " + aadhar);
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("people")
  //         .doc(aadhar)
  //         .get()
  //         .then((DocumentSnapshot result) async {
  //       if (result.exists) {
  //         print("VALID");
  //         response = "done";
  //       } else {
  //         print("Aadhar not found " + aadhar);
  //         response = "failed";
  //       }
  //     }).catchError((err) => print("then " + err.toString()));
  //     return response;
  //   } catch (e) {
  //     print("Exception: " + e.toString());
  //     response = "failed";
  //     return response;
  //   }
  // }

  static Future<String> familyAadharAlreadyLinkedOrNot(
      {String childAadhar}) async {
    String response = " ";
    print("Aadhar: " + childAadhar);
    try {
      await FirebaseFirestore.instance
          .collection("people")
          .doc(childAadhar)
          .get()
          .then((DocumentSnapshot result) async {
        if (result.exists) {
          if (result['child'] == true) {
            print("Already Linked");
            response = "true";
          } else {
            print("Not linked");
            response = "false";
          }
        } else {
          print("Aadhar not found");
          response = "failed";
        }
      }).catchError((err) => print("then " + err.toString()));
      return response;
    } catch (e) {
      print("Exception: " + e.toString());
      response = "failed";
      return response;
    }
  }

  static Future<String> linkFamilyAadharToParent(
      {String parentAadhar, String childAadhar}) async {
    String response = " ";
    try {
      await FirebaseFirestore.instance
          .collection("aadhar_form_status")
          .doc(parentAadhar)
          .update({
        'family_aadhar': FieldValue.arrayUnion(
            [int.parse(childAadhar)]), //int.parse(childAadhar),
        // /*int.parse(childAadhar),*/FieldValue.arrayUnion(int.parse(childAadhar)),
      });
      print("DONE");
      response = "done";
      return response;
    } catch (e) {
      print("Exception: " + e.toString());
      response = "failed";
      return response;
    }
  }

  static Future<String> linkParentAadharToFamilyMember(
      {String parentAadhar, String childAadhar}) async {
    String response = " ";
    try {
      await FirebaseFirestore.instance
          .collection("people")
          .doc(childAadhar)
          .get()
          .then((DocumentSnapshot result) async {
        if (result.exists) {
          await FirebaseFirestore.instance
              .collection("people")
              .doc(childAadhar)
              .update({
            'parent_aadhar': int.parse(parentAadhar),
            'child': true,
          });
          print("DONE");
          response = "done";
        } else {
          print("Aadhar not found");
          response = "failed";
        }
      }).catchError((err) => print("then " + err.toString()));

      return response;
    } catch (e) {
      print("Exception: " + e.toString());
      response = "failed";
      return response;
    }
  }

  static Future<String> phase2TrueInFamilyMember({String childAadhar}) async {
    String response = " ";
    print("Aadhar: " + childAadhar);
    try {
      await FirebaseFirestore.instance
          .collection("aadhar_form_status")
          .doc(childAadhar)
          .get()
          .then((DocumentSnapshot result) async {
        if (result.exists) {
          await FirebaseFirestore.instance
              .collection("aadhar_form_status")
              .doc(childAadhar)
              .update({
            'p2_status': true,
          });
          print("DONE");
          response = "done";
        } else {
          await FirebaseFirestore.instance
              .collection("aadhar_form_status")
              .doc(childAadhar)
              .set({
            'p2_status': true,
          });
          print("DONE");
          response = "done";

          // print("Aadhar not found in aadhar_form_status found");
          // response = "failed";
        }
      }).catchError((err) => print("then " + err.toString()));
      return response;
    } catch (e) {
      print("Exception: " + e.toString());
      response = "failed";
      return response;
    }
  }

  static Future<String> uploadingPhase1Data(
      {@required bool isWithAadharCard,
      @required bool isWithoutAadharCard,
      @required bool isSelfUser,
      String aadhar,
      String fname,
      String lname,
      String mname,
      String sexType,
      int age,
      int phone,
      String maritalStatus,
      String religion,
      String cast,
      String isDisability,
      String disability, // if isDisability is true...
      String motherTongue,
      String otherLanguage,
      String highestEducation,
      String workDuration,
      String economicActivity,
      String occupation,
      String industry,
      String worker,
      String birthPlace,
      String lastResidence,
      String migration,
      String reason,
      String durationOfStay}) async {
    String response = "";
    print(aadhar);
    try {
      await FirebaseFirestore.instance
          .collection("people")
          .doc(aadhar)
          .collection("phase1")
          .doc(aadhar)
          .get()
          .then((value) async {
        if (!value.exists) {
          print("value is null..");
          print("New data will be upload...");

          await FirebaseFirestore.instance
              .collection('people')
              .doc(aadhar)
              .set({
            'isWithAadharCard': isWithAadharCard,
            'isWithoutAadharCard': isWithoutAadharCard,
            'isSelfUser': isSelfUser,
          });

          await FirebaseFirestore.instance
              .collection("people")
              .doc(aadhar)
              .collection("phase1")
              .doc(aadhar)
              .set({
            'isWithAadharCard': isWithAadharCard,
            'isWithoutAadharCard': isWithoutAadharCard,
            'isSelfUser': isSelfUser,
            'firstName': fname,
            'middleName': mname,
            'lastName': lname,
            'sexType': sexType,
            'age': age,
            'phone': phone,
            'maritalStatus': maritalStatus,
            'religion': religion,
            'cast': cast,
            'isDisability': isDisability,
            'disabilityType': disability,
            'motherTongue': motherTongue,
            'otherLanguage': otherLanguage,
            'highestEducation': highestEducation,
            'workDuration': workDuration,
            'economicActivity': economicActivity,
            'occupation': occupation,
            'industry': industry,
            'workerClass': worker,
            'birthPlace': birthPlace,
            'lastResidence': lastResidence,
            'migration': migration,
            'reason': reason,
            'durationOfStayVillage': durationOfStay
          });

          print("New Data uploaded Successfully...");
          await FirebaseFirestore.instance
              .collection("aadhar_form_status")
              .doc(aadhar)
              .update(({'p1_status': true}));
          print("Phase1 status true...");
        } else {
          print("value: " + value.toString());
          print("Data already stored in db...");
          await FirebaseFirestore.instance
              .collection('people')
              .doc(aadhar)
              .update({
            'isWithAadharCard': isWithAadharCard,
            'isWithoutAadharCard': isWithoutAadharCard,
            'isSelfUser': isSelfUser,
          });
          await FirebaseFirestore.instance
              .collection("people")
              .doc(aadhar)
              .collection("phase1")
              .doc(aadhar)
              .update(({
                'isWithAadharCard': isWithAadharCard,
                'isWithoutAadharCard': isWithoutAadharCard,
                'isSelfUser': isSelfUser,
                'firstName': fname,
                'middleName': mname,
                'lastName': lname,
                'sexType': sexType,
                'age': age,
                'phone': phone,
                'maritalStatus': maritalStatus,
                'religion': religion,
                'cast': cast,
                'isDisability': isDisability,
                'disabilityType': disability,
                'motherTongue': motherTongue,
                'otherLanguage': otherLanguage,
                'highestEducation': highestEducation,
                'workDuration': workDuration,
                'economicActivity': economicActivity,
                'occupation': occupation,
                'industry': industry,
                'workerClass': worker,
                'birthPlace': birthPlace,
                'lastResidence': lastResidence,
                'migration': migration,
                'reason': reason,
                'durationOfStayVillage': durationOfStay
              }));
          print("Data updated Successfully...");
        }
      }).catchError((err) => print("then " + err.toString()));
      response = "done";
      return response;
    } catch (e) {
      print("Exception: " + e.toString());
      response = "falied";
      return response;
    }
  }

  static Future<String> uploadingPhase2Data({
    @required bool isWithAadharCard,
    @required bool isWithoutAadharCard,
    @required bool isSelfUser,
    String aadhar,
    int houseNo,
    String floorMaterial,
    String wallMaterial,
    String roofMaterial,
    String useOfHouse,
    int numberOfCouple,
    int numberOfPerson,
    String conditionOfHouse,
    String ownershipStatus,
    String mainSourceOfDrinkingWater,
    String availabilityOfDrinkingWater,
    String mainSourceOfLighting, // if isDisability is true...
    String accessLatrine,
    String wasteWaterOutletConnected,
    String bathingFacility,
  }) async {
    String response = "";
    print(aadhar);
    try {
      await FirebaseFirestore.instance
          .collection("people")
          .doc(aadhar)
          .collection("phase2")
          .doc(aadhar)
          .get()
          .then((value) async {
        if (!value.exists) {
          print("value is null..");
          print("New data will be upload...");
          await FirebaseFirestore.instance
              .collection('people')
              .doc(aadhar)
              .set({
            'isWithAadharCard': isWithAadharCard,
            'isWithoutAadharCard': isWithoutAadharCard,
            'isSelfUser': isSelfUser,
          });
          await FirebaseFirestore.instance
              .collection("people")
              .doc(aadhar)
              .collection("phase2")
              .doc(aadhar)
              .set({
            'isWithAadharCard': isWithAadharCard,
            'isWithoutAadharCard': isWithoutAadharCard,
            'isSelfUser': isSelfUser,
            'houseNo': houseNo,
            'floorMaterial': floorMaterial,
            'wallMaterial': wallMaterial,
            'roofMaterial': roofMaterial,
            'useOfHouse': useOfHouse,
            'conditionOfHouse': conditionOfHouse,
            'numberOfPerson': numberOfPerson,
            'ownershipStatus': ownershipStatus,
            'numberOfCouple': numberOfCouple,
            'mainSourceOfDrinkingWater': mainSourceOfDrinkingWater,
            'availabilityOfDrinkingWater': availabilityOfDrinkingWater,
            'mainSourceOfLighting': mainSourceOfLighting,
            'accessLatrine': accessLatrine,
            'wasteWaterOutletConnected': wasteWaterOutletConnected,
            'bathingFacility': bathingFacility
          });

          print("New Data uploaded Successfully...");
          await FirebaseFirestore.instance
              .collection("aadhar_form_status")
              .doc(aadhar)
              .update(({'p2_status': true}));
          print("Phase1 status true...");
        } else {
          print("value: " + value.toString());
          print("Data already stored in db...");
          await FirebaseFirestore.instance
              .collection('people')
              .doc(aadhar)
              .update({
            'isWithAadharCard': isWithAadharCard,
            'isWithoutAadharCard': isWithoutAadharCard,
            'isSelfUser': isSelfUser,
          });
          await FirebaseFirestore.instance
              .collection("people")
              .doc(aadhar)
              .collection("phase2")
              .doc(aadhar)
              .update(({
                'isWithAadharCard': isWithAadharCard,
                'isWithoutAadharCard': isWithoutAadharCard,
                'isSelfUser': isSelfUser,
                'houseNo': houseNo,
                'floorMaterial': floorMaterial,
                'wallMaterial': wallMaterial,
                'roofMaterial': roofMaterial,
                'useOfHouse': useOfHouse,
                'conditionOfHouse': conditionOfHouse,
                'numberOfPerson': numberOfPerson,
                'ownershipStatus': ownershipStatus,
                'numberOfCouple': numberOfCouple,
                'mainSourceOfDrinkingWater': mainSourceOfDrinkingWater,
                'availabilityOfDrinkingWater': availabilityOfDrinkingWater,
                'mainSourceOfLighting': mainSourceOfLighting,
                'accessLatrine': accessLatrine,
                'wasteWaterOutletConnected': wasteWaterOutletConnected,
                'bathingFacility': bathingFacility
              }));
          print("Data updated Successfully...");
        }
      }).catchError((err) => print("then " + err.toString()));
      response = "done";
      return response;
    } catch (e) {
      print("Exception: " + e.toString());
      response = "falied";
      return response;
    }
  }

  static Future<DocumentSnapshot> getUserPhase1Data({String aadhar}) async {
    //  String response = "";
    DocumentSnapshot result;
    print(aadhar);

    try {
      await FirebaseFirestore.instance
          .collection("people")
          .doc(aadhar)
          .collection("phase1")
          .doc(aadhar)
          .get()
          .then((value) async {
        if (value.exists) {
          //   print("durationOfStayVillage: "+value['durationOfStayVillage']);
          result = value;
          return result;
        } else {
          print("document does not exist in database");
          return null;
        }
      }).catchError((err) => print("then " + err.toString()));
      //response = "done";

      return result;
    } catch (e) {
      print("Exception: " + e.toString());
      // response = "falied";
      return null;
    }
  }

  static Future<DocumentSnapshot> isChildAadhar({String aadhar}) async {
    //  String response = "";
    DocumentSnapshot result;
    print(aadhar);

    try {
      await FirebaseFirestore.instance
          .collection("people")
          .doc(aadhar)
          .get()
          .then((value) async {
        if (value.exists) {
          //  print("durationOfStayVillage: "+value['durationOfStayVillage']);
          if (value['child']) {
            print("its child aadhar...");
            print(value['parent_aadhar']);
            result = value;
            return result;
          } else {
            print("its not child...");
            return null;
          }
        } else {
          print("document does not exist in database");
          return null;
        }
      }).catchError((err) => print("then " + err.toString()));
      //response = "done";

      return result;
    } catch (e) {
      print("Exception: " + e.toString());
      // response = "falied";
      return null;
    }
  }

  static Future<DocumentSnapshot> getUserPhase2Data({String aadhar}) async {
    //  String response = "";
    DocumentSnapshot result;
    print(aadhar);

    try {
      await FirebaseFirestore.instance
          .collection("people")
          .doc(aadhar)
          .collection("phase2")
          .doc(aadhar)
          .get()
          .then((value) async {
        if (value.exists) {
          //  print("durationOfStayVillage: "+value['durationOfStayVillage']);
          result = value;
          return result;
        } else {
          print("document does not exist in database");
          return null;
        }
      }).catchError((err) => print("then " + err.toString()));
      //response = "done";

      return result;
    } catch (e) {
      print("Exception: " + e.toString());
      // response = "falied";
      return null;
    }
  }
}
