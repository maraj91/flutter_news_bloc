import 'package:flutter/material.dart';
import 'base_colors.dart';

class AppColors implements BaseColors{
  Map<int, Color> _primary =
  {
    50:Color.fromRGBO(218, 107, 255, 0.1),
    100:Color.fromRGBO(218, 107, 255, 0.2),
    200:Color.fromRGBO(218, 107, 255, 0.3),
    300:Color.fromRGBO(218, 107, 255, 0.4),
    400:Color.fromRGBO(218, 107, 255, 0.5),
    500:Color.fromRGBO(218, 107, 255, 0.6),
    600:Color.fromRGBO(218, 107, 255, 0.7),
    700:Color.fromRGBO(218, 107, 255, 0.8),
    800:Color.fromRGBO(218, 107, 255, 0.9),
    900:Color.fromRGBO(218, 107, 255, 1.0),
  };

  @override
  MaterialColor get colorAccent => Colors.amber;

  @override
  MaterialColor get colorPrimary => MaterialColor(0xFFEFB7D2,_primary);

  @override
  Color get colorPrimaryText => const Color(0xff38937f);

  @override
  Color get colorSecondaryText => const Color(0xff3b3b3b);

  @override
  Color get colorAppbarTitle => const Color(0xff4f2b51);

  @override
  Color get colorLink => const Color(0xff7c06ec);

  @override
  Color get colorBG => const Color(0xffefefef);

  @override
  Color get countryBottomLabel => const Color(0x9dffc107);

  @override
  Color get countrySelectionBorderColor => const Color(0xffff69f8);

}