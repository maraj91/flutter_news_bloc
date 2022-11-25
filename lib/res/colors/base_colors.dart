import 'package:flutter/material.dart';

abstract class BaseColors{
  //theme color
  MaterialColor get colorPrimary;
  MaterialColor get colorAccent;
  //text color
  Color get colorPrimaryText;
  Color get colorSecondaryText;
  Color get colorAppbarTitle;
  //Extra color
  Color get colorLink;
  Color get colorBG;
  Color get countryBottomLabel;
  Color get countrySelectionBorderColor;
}