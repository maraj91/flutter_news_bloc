
import 'package:flutter/material.dart';

abstract class Strings {

  static Strings? of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  String get newsHome;
  String get newsDetails;
  String get newsAuthorTitle;
  String get noNewsFound;
  String get menuCountry;
  String get menuSubCategories;
  String get menuAboutUs;
  String get subMenuAll;
  String get subMenuBusiness;
  String get subMenuEntertainment;
  String get subMenuHealth;
  String get subMenuScience;
  String get subMenuSports;
  String get subMenuTechnology;
}