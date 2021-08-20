class UserDataModel {
  final String name;
  final String aadharNumber;
  final String mobileNumber;

  UserDataModel({
    this.name,
    this.aadharNumber,
    this.mobileNumber,
  });

  factory UserDataModel.fromDocs(Map<String, dynamic> doc) {
    return UserDataModel(
      name: doc['name'],
      mobileNumber: doc['mobileNumber'],
      aadharNumber: doc['aadharNumber'],
    );
  }
  factory UserDataModel.copy(UserDataModel user) {
    var data = Map<String, dynamic>();
    data['name'] = user.name;
    data['aadharNumber'] = user.aadharNumber;
    print("====USER MOBILE====" + user.mobileNumber.toString());
    data['mobileNumber'] = user.mobileNumber.toString();

    return UserDataModel(
      name: data['name'],
      aadharNumber: data['aadharNumber'] ?? '',
      mobileNumber: data['mobileNumber'],
    );
  }
  Map toMap(UserDataModel user) {
    var data = Map<String, dynamic>();
    data['name'] = user.name;
    data['aadharNumber'] = user.aadharNumber;
    data['mobileNumber'] = user.mobileNumber;
    return data;
  }
}
