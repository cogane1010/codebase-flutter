import 'package:flutter/cupertino.dart';

import '../../../configs/app_localizations.dart';
import '../../../data/model/base_response_api.dart';

import '../../../data/repositories/change_password_api.dart';
import '../../../data/repositories/home_api.dart';

class DashBoardViewModel extends ChangeNotifier {
  int indexSelectPage = 0;
  bool isHidePassword = true;
  bool isReHidePassword = true;
  ChangePasswordApi api = ChangePasswordApi();
  bool isErrorInfo = false;
  BaseResponseApi? contactAllCourseResponse;
  HomeApi homeApi = HomeApi();
  void selectedPage(int index) {
    if (index == indexSelectPage) return;
    indexSelectPage = index;
    notifyListeners();
  }

  void initViewModel() {
    indexSelectPage = 0;
    isErrorInfo = false;
  }

  String? validatePassWord(String value, BuildContext context) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value.isEmpty) {
      return AppLocalizations.of(context)!
          .translate('require_enter_password_message');
    }
    if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context)!.translate('pw_pattern_not_match');
    }
    return null;
  }

  setIsHidePassWord(bool isValue) {
    isHidePassword = isValue;
    notifyListeners();
  }

  setIsReHidePassWord(bool isValue) {
    isReHidePassword = isValue;
    notifyListeners();
  }

  void isValidateInfoChangePassword(bool isValue) {
    isErrorInfo = isValue;
    notifyListeners();
  }
}
