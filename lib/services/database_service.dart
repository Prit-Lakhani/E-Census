import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static final _firestore = FirebaseFirestore.instance;
  final _aadharRef = _firestore.collection('aadhar-data');

  Future<String> fetchMobileNumber(String aadharNumber) async {
    Future<DocumentSnapshot> snapshot;
    String mobileNumber;
    if (aadharNumber != null) {
      await _aadharRef.doc(aadharNumber).get().then((snapshot) {
        mobileNumber = snapshot.data()["mobileNumber"].toString();
      });
      print(mobileNumber);
      return mobileNumber;
    }
  }
}
