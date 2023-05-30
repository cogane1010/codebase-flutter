import 'package:brg_management/configs/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showFeatureIsDeveloping(BuildContext context) {
  Fluttertoast.showToast(
      msg: AppLocalizations.of(context)!.translate('feature_is_developing'));
}

// Top Level Function
String interpolate(String string, List<String> params) {
  String result = string;
  for (int i = 0; i < params.length; i++) {
    result = result.replaceAll('{$i}', params[i]);
  }

  return result;
}

extension StringExtension on String {
  String format(List<String> params) => interpolate(this, params);
}
