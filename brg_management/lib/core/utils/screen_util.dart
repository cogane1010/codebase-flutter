import 'package:flutter/material.dart';

class ScreenUtils {
  static void openScreen(BuildContext context, String screenName) {
    Navigator.of(context).pushNamed(screenName);
  }

  static void openScreenWithData(
      BuildContext context, String screenName, Object args) {
    Navigator.of(context).pushNamed(screenName, arguments: args);
  }

  static void openScreenWithDataForResult(
      BuildContext context, String screenName, Object args, Function action) {
    Navigator.of(context).pushNamed(screenName, arguments: args).then((result) {
      if (result != null) {
        action(result);
      }
    });
  }

  static void replaceScreen(BuildContext context, String screenName) {
    Navigator.of(context).pushReplacementNamed(screenName);
  }
  static void replaceScreenWithData(BuildContext context, String screenName,Object args) {
    Navigator.of(context).pushReplacementNamed(screenName,arguments: args);
  }

  static void openScreenAndRemoveUtil(BuildContext context, String screenName,{Object? arguments}) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(screenName, (Route<dynamic> route) => false,arguments: arguments);
  }

  static void closeScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void closeScreenWithData(BuildContext context, Object args) {
    Navigator.of(context).pop(args);
  }
  static void popToScreen(BuildContext context,String screenName) {
    Navigator.of(context).popUntil((route) => route.settings.name == screenName);
  }
}
