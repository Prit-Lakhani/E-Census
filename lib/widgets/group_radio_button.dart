import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:e_census_2021/constants/colors.dart';
import 'package:flutter/material.dart';

class RadioGroup extends StatelessWidget {
  List<String> buttonLabels;
  List<String> buttonValues;
  Function(String) onRadioButtonClick;
  bool autoWidth;
  RadioGroup(
      {@required this.buttonLabels,
      @required this.buttonValues,
      @required this.onRadioButtonClick,
      this.autoWidth});
  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      buttonLables: buttonLabels,
      buttonValues: buttonValues,
      radioButtonValue: (value) {
        onRadioButtonClick(value);
      },
      selectedBorderColor: kSecondaryBackgroundColor,//kPrimaryBackgroundColor,
      unSelectedBorderColor: kSecondaryBackgroundColor,
      enableButtonWrap: true,
      absoluteZeroSpacing: false,
      enableShape: true,
      //  autoWidth: true,
      spacing: 6,
      elevation: 1,
      unSelectedColor: Theme.of(context).canvasColor,
      buttonTextStyle: ButtonTextStyle(
          selectedColor: Colors.white,//kPrimaryBackgroundColor,
          unSelectedColor: kSecondaryBackgroundColor,
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      selectedColor: kSecondaryBackgroundColor,
      autoWidth: autoWidth ?? false,
    );
  }
}
