import 'package:brg_management/data/repositories/logout_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../configs/router.dart';
import '../../../core/shared_preferences/shared_preferences.dart';
import '../../../core/utils/screen_util.dart';
import '../../../data/local/user_session.dart';

class SettingsViewModel extends ChangeNotifier {
  var enableBiometric = false;
  SharedPreferences sharedPreferences = SharedPreferences.instance;
  LogoutApi logoutApi = LogoutApi();
  final storage = new FlutterSecureStorage();

  void initViewModel() async {
    bool? isActive = await SharedPreferences.instance
        .getActiveBiometric(UserSession.instance.usn);
    enableBiometric = isActive;
    notifyListeners();
  }

  void logOutClient(BuildContext context) {
    UserSession.instance.token = '';
    // sharedPreferences.remove("user_name");
    // sharedPreferences.remove("pw");
    // sharedPreferences.remove("active_biometric");
    ScreenUtils.openScreenAndRemoveUtil(context, AppRouter.login);
    logoutSever();
  }

  void logoutSever() async {
    logoutApi.logout();
  }

  void activeLoginBiometric(bool isActive) async {
    storage.write(key: "usn", value: isActive ? UserSession().usn : '');
    storage.write(key: 'pw', value: isActive ? UserSession().pw : '');

    sharedPreferences.setActiveLoginBiometric(
        isActive, UserSession.instance.usn);
    enableBiometric = isActive;
    notifyListeners();
  }
}
