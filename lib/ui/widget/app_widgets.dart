import 'package:flutter/material.dart';
import '../../res/app_context_extension.dart';

class AppWidgets {
  static getAppBar(BuildContext context, String title) {
    return AppBar(
      iconTheme: context.resources.style.appbarIconTheme,
      centerTitle: true,
      title: Text(
        title,
        style: context.resources.style.appbarTitleStyle,
      ),
    );
  }

  static getAppBarWithSingleIcon(BuildContext context, String title, Function() callback, Icon iconData) {
    return AppBar(
      iconTheme: context.resources.style.appbarIconTheme,
      centerTitle: true,
      title: Text(
        title,
        style: context.resources.style.appbarTitleStyle,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: context.resources.dimension.defaultMargin),
          child: GestureDetector(
            onTap: callback,
            child: iconData,
          ),
        )
      ],
    );
  }

  static getDefaultSizedBox(BuildContext context) {
    return SizedBox(
      height: context.resources.dimension.defaultMargin,
    );
  }

  static getCenterLoadingView() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static getBuildNoResult(BuildContext context, String errorMessage) {
    return Padding(
      padding: EdgeInsets.all(context.resources.dimension.defaultMargin),
      child: Center(
        child: Text(errorMessage),
      ),
    );
  }
}
