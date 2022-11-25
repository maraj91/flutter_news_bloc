import 'package:flutter/cupertino.dart';
import 'package:news_flutter_block/res/strings/english_strings.dart';
import 'package:news_flutter_block/res/style/app_style.dart';
import 'colors/app_colors.dart';
import 'dimentions/app_dimension.dart';
import 'strings/strings.dart';

class Resources {

  final BuildContext _context;
  Resources(this._context);

  Strings? get strings {
    return EnglishStrings();
  }

  AppColors get color {
    return AppColors();
  }

  AppDimension get dimension {
    return AppDimension();
  }

  AppStyle get style {
    return AppStyle();
  }

  static Resources of(BuildContext context){
    return Resources(context);
  }
}