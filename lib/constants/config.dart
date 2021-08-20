import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

class P1Controller {
  static String sextype = '';
  static String maritalStatus = '';
  static String religion = '';
  static String cast = '';
  static String isDisability;
  // static String disability = '';
  static String disabilityType = '';
  static String workDuration = '';
  static String economicActivity = '';
  static String worker = '';
  static String migration = '';
  static String reason = '';
  // static String literacyStatus = '';
  // static String attendanceSattus = '';
  // static bool isAttending;

  static TextEditingController firstNameController = TextEditingController();
  static TextEditingController lastNameController = TextEditingController();
  static TextEditingController middleNameController = TextEditingController();
  static TextEditingController ageController = TextEditingController();
  static TextEditingController phoneNumberController = TextEditingController();
  static TextEditingController ageAtMarriageController =
      TextEditingController();
  static TextEditingController motherTongueController = TextEditingController();
  static TextEditingController otherLanguageController =
      TextEditingController();
  static TextEditingController highestEducationController =
      TextEditingController();
  static TextEditingController occupationController = TextEditingController();
  static TextEditingController industryController = TextEditingController();
  static TextEditingController birthPlaceController = TextEditingController();
  static TextEditingController lastResidenceController =
      TextEditingController();
  static TextEditingController durationOfStayController =
      TextEditingController();
  // TextEditingController firstNameController = TextEditingController();
  // TextEditingController firstNameController = TextEditingController();

  static List<String> lSexType = ['Male', 'Female', 'Transgender'];
  static List<String> vSexType = ['Male', 'Female', 'Transgender'];

  static List<String> lCurrentMaritalStatus = [
    'Never married',
    'Currently married',
    'Widowed',
    'Separated',
    'Divorced'
  ];
  static List<String> vCurrentMaritalStatus = [
    'Never married',
    'Currently married',
    'Widowed',
    'Separated',
    'Divorced'
  ];

  static List<String> lReligion = [
    'Hindu',
    'Muslim',
    'Christian',
    'Sikh',
    'Buddhist',
    'jain'
  ];
  static List<String> vReligion = [
    'Hindu',
    'Muslim',
    'Christian',
    'sikh',
    'Divorced',
    'jain'
  ];

  static List<String> lCast = ['Open', 'OBC', 'SC', 'ST', 'Other'];
  static List<String> vCast = ['Open', 'OBC', 'SC', 'ST', 'Other'];

  static List<String> lDisability = ['Yes', 'No'];
  static List<String> vDisability = ['Yes', 'No'];

  static List<String> lDisabilityType = [
    'In Seeing',
    'In Hearing',
    'In Speech',
    'In Movement',
    'Multiple Disability',
    'Mental Retardation',
    'Mental Illness',
    'Any Other'
  ];
  static List<String> vDisabilityType = [
    'In Seeing',
    'In Hearing',
    'In Speech',
    'In Movement',
    'Multiple Disability',
    'Mental Retardation',
    'Mental Illness',
    'Any Other'
  ];

  static List<String> lWorkDuration = [
    'Main work (worked < 6 Month)',
    'Marginal worker (worked < 3 Month > 6 Month)',
    'less than 3 month',
    'non-worker'
  ];
  static List<String> vWorkDuration = [
    'Main work (worked < 6 Month)',
    'Marginal worker (worked < 3 Month > 6 Month)',
    'less than 3 month',
    'non-worker'
  ];

  static List<String> lEconomicActivity = [
    'Cultivator',
    'Agricultural Labourer Worker in',
    'Household Industry ',
    'Other Work'
  ];
  static List<String> vEconomicActivity = [
    'Cultivator',
    'Agricultural Labourer Worker in',
    'Household Industry ',
    'Other Work'
  ];

  static List<String> lWorker = ['Employer', 'Single Worker', 'Family Worker'];
  static List<String> vWorker = ['Employer', 'Single Worker', 'Family Worker'];

  static List<String> lNonEconomicActivity = [
    'Student',
    'household duties',
    'dependent',
    'pensioner',
    'rentier',
    'beggar',
    'other'
  ];
  static List<String> vNonEconomicActivity = [
    'Student',
    'household duties',
    'dependent',
    'pensioner',
    'rentier',
    'beggar',
    'other'
  ];

  static List<String> lMigration = ['Rural', 'Urban'];
  static List<String> vMigration = ['Rural', 'Urban'];

  static List<String> lReason = [
    'Work/Employment',
    'Business',
    'Education',
    'Household',
    'Any other',
    'Marriage'
  ];
  static List<String> vReason = [
    'Work/Employment',
    'Business',
    'Education',
    'Household',
    'Any other',
    'Marriage'
  ];
}

class P2Controller {
  static String floorMaterial = '';
  static String wallMaterial = '';
  static String roofMaterial = '';
  static String useOfHouse;
  static String conditionOfHouse;
  static String ownershipStatus;
  static String mainSourceOfDrinkingWater;
  static String availabilityOfDrinkingWater;
  static String mainSourceOfLighting;
  static String accessLatrine;
  static String wasteWaterOutletConnected;
  static String bathingFacility;

  static TextEditingController houseNumberController = TextEditingController();
  static TextEditingController numberOfPersonController =
      TextEditingController();
  static TextEditingController numberOfCoupleController =
      TextEditingController();

  static List<String> lFloorMaterial = [
    'Wood',
    'Bamboo',
    'Burnt brick',
    'Cement',
    'Mosaic',
    'floor tiles',
    'Any other'
  ];
  static List<String> vFloorMaterial = [
    'Wood',
    'Bamboo',
    'Burnt brick',
    'Cement',
    'Mosaic',
    'floor tiles',
    'Any other'
  ];

  static List<String> lWallMaterial = [
    'Grass/ thatch/ bamboo etc',
    'Plastic/polythene',
    'Mud/ unburnt brick',
    'Wood',
    'Stone not packed with mortar',
    'G.I./metal/ asbestos sheets',
    'Burnt brick',
    'Concrete',
    'Any Other...'
  ];
  static List<String> vWallMaterial = [
    'Grass/ thatch/ bamboo etc',
    'Plastic/polythene',
    'Mud/ unburnt brick',
    'Wood',
    'Stone not packed with mortar',
    'G.I./metal/ asbestos sheets',
    'Burnt brick',
    'Concrete',
    'Any Other...'
  ];

  static List<String> lRoofMaterial = [
    'Grass/ thatch/ bamboo etc',
    'Plastic/polythene',
    'Hand made tiles',
    'Machine made tiles',
    'Burnt brick',
    'Stone',
    'Slate',
    'G.I./metal',
    'asbestos sheets',
    'Concrete',
    'Any Other...'
  ];
  static List<String> vRoofMaterial = [
    'Grass/ thatch/ bamboo etc',
    'Plastic/polythene',
    'Hand made tiles',
    'Machine made tiles',
    'Burnt brick',
    'Stone',
    'Slate',
    'G.I./metal',
    'asbestos sheets',
    'Concrete',
    'Any Other...'
  ];

  static List<String> lUSeOfHouse = [
    'Residence',
    'Residence-cum-other use',
    'Shop/ office',
    'School/ college etc',
    'Hotel/ lodge/',
    'Factory/ workshop/',
    'guest house etc',
    'Hospital/ dispensary etc',
    'workshed etc',
    'Place of worship',
    'Other non-residential use',
    'Vacant'
  ];
  static List<String> vUSeOfHouse = [
    'Residence',
    'Residence-cum-other use',
    'Shop/ office',
    'School/ college etc',
    'Hotel/ lodge/',
    'Factory/ workshop/',
    'guest house etc',
    'Hospital/ dispensary etc',
    'workshed etc',
    'Place of worship',
    'Other non-residential use',
    'Vacant'
  ];

  static List<String> lConditionOfHouse = ['Good', 'Livable', 'Dilapidated'];
  static List<String> vConditionOfHouse = ['Good', 'Livable', 'Dilapidated'];

  static List<String> lOwnershipStatus = [
    'Owned',
    'Rented but has own house elsewhere',
    'Rented and doesn’t own any house',
    'Any other'
  ];
  static List<String> vOwnershipStatus = [
    'Owned',
    'Rented but has own house elsewhere',
    'Rented and doesn’t own any house',
    'Any other'
  ];

  static List<String> lMainSourceOfDrinkingWater = [
    'Tap water from treated source',
    'Tap water from un-treated source',
    'Well',
    'Hand Pump',
    'Tubewell/ borehole',
    'Spring',
    'River/canal',
    'Tank/pond/lake',
    'Packaged/bottled water',
    'Other sources'
  ];
  static List<String> vMainSourceOfDrinkingWater = [
    'Tap water from treated source',
    'Tap water from un-treated source',
    'Well',
    'Hand Pump',
    'Tubewell/ borehole',
    'Spring',
    'River/canal',
    'Tank/pond/lake',
    'Packaged/bottled water',
    'Other sources'
  ];

  static List<String> lAvailabilityOfDrinkingWater = [
    'Septic tank',
    'Other system',
    'With slab/ventilated improved pit',
    'Without slab/open pit',
    'Night soil removed by human',
    'Night soil serviced by animals'
  ];
  static List<String> vAvailabilityOfDrinkingWater = [
    'Septic tank',
    'Other system',
    'With slab/ventilated improved pit',
    'Without slab/open pit',
    'Night soil removed by human',
    'Night soil serviced by animals'
  ];

  static List<String> lMainSourceOfLighting = [
    'Electricity',
    'Kerosene',
    'Solar',
    'Other oil',
    'Any other',
    'No lighting'
  ];
  static List<String> vMainSourceOfLighting = [
    'Electricity',
    'Kerosene',
    'Solar',
    'Other oil',
    'Any other',
    'No lighting'
  ];

  static List<String> lAccessLatrine = [
    'Exclusively for household use only',
    'Shared with other household',
    'Public latrine',
    'Not Available'
  ];
  static List<String> vAccessLatrine = [
    'Exclusively for household use only',
    'Shared with other household',
    'Public latrine',
    'Not Available'
  ];

  static List<String> lWasteWaterOutletConnected = [
    'Closed drainage',
    'Open drainage',
    'No drainage'
  ];
  static List<String> vWasteWaterOutletConnected = [
    'Closed drainage',
    'Open drainage',
    'No drainage'
  ];

  static List<String> lBathingFacility = [
    'Yes: Bathroom',
    'Enclosure without roof',
    'Not Available'
  ];
  static List<String> vBathingFacility = [
    'Yes: Bathroom',
    'Enclosure without roof',
    'Not Available'
  ];
}

class User {
  String aadharNumber;
  static TextEditingController userAadharController = TextEditingController();
  static TextEditingController familyAadharController = TextEditingController();
}

class P1Data {
  String field;
  String value;

  P1Data({this.field, this.value});

  static List<String> values = [
    'firstName',
    'middleName',
    'lastName',
    'sexType',
    'age',
    'phone',
    'maritalStatus',
    'religion',
    'cast',
    'isDisability',
    'disabilityType',
    'motherTongue',
    'otherLanguage',
    'highestEducation',
    'workDuration',
    'economicActivity',
    'occupation',
    'industry',
    'workerClass',
    'birthPlace',
    'lastResidence',
    'migration',
    'reason',
    'durationOfStayVillage'
  ];

  static List<String> fields = [
    'First Name',
    'Middle Name',
    'Last Name',
    'Sex Type',
    'Age',
    'Mobile Number',
    'Marital Status',
    'Religion',
    'Cast',
    'You have Disability?',
    'Disability Type',
    'Mother Tongue',
    'Other Known Language',
    'Highest Education',
    'Worked any time during last year?',
    'Category of Economic Activity',
    'Occupation',
    'Nature of Industry',
    'Class of Worker',
    'Birth Place',
    'Place of last Residence',
    'Migration',
    'Reason',
    'Duration Of Stay Village'
  ];

  static var names = <P1Data>[];

  static void creatDataTableRow(dynamic data) {
    names.clear();
    for (int i = 0; i < fields.length; i++) {
      // String value = values[i];
      // String formData = data[value];
      // print(formData);
      names.add(
        P1Data(field: fields[i], value: data[values[i]].toString()),
      );
    }
    // print("Row data: " + names.);
  }
}

class P2Data {
  String field;
  String value;

  P2Data({this.field, this.value});

  static List<String> values = [
    'houseNo',
    'floorMaterial',
    'wallMaterial',
    'roofMaterial',
    'useOfHouse',
    'conditionOfHouse',
    'numberOfPerson',
    'ownershipStatus',
    'numberOfCouple',
    'mainSourceOfDrinkingWater',
    'availabilityOfDrinkingWater',
    'mainSourceOfLighting',
    'accessLatrine',
    'wasteWaterOutletConnected',
    'bathingFacility'
  ];

  static List<String> fields = [
    'House No',
    'Floor Material',
    'Wall Material',
    'Roof Material',
    'useOfHouse',
    'Condition Of House',
    'Number Of Person',
    'Ownership Status',
    'Number Of Couple',
    'Main Source Of Drinking Water',
    'Availability Of Drinking Water',
    'Main Source Of Lighting',
    'Access Latrine',
    'Waste Water Outlet Connected',
    'Bathing Facility'
  ];

  static var names = <P2Data>[];

  static void creatDataTableRow(dynamic data) {
    names.clear();
    for (int i = 0; i < fields.length; i++) {
      // String value = values[i];
      // String formData = data[value];
      // print(formData);
      names.add(
        P2Data(field: fields[i], value: data[values[i]].toString()),
      );
    }
    // print("Row data: " + names.);
  }
}

void showToast(message, BuildContext context) {
  print(message);
  Toast.show(message, context,
      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
}

void changeScreen({BuildContext context, Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false);
}
