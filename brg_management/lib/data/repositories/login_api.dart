import 'dart:convert';

import 'package:brg_management/configs/base_api.dart';

import '../local/user_session.dart';
import '../model/response.dart';

class LoginApi extends BaseApi {
  Future<ApiResponse> onLogin(String userName, String password,
      {String? otpid, String? otpcode}) async {
    Map requestBody = {"username": userName, "password": password};

    var response = await httpRequest.sendPost(
        contentType: 'application/json',
        uri: getFullPathAuth('/api/app/Login'),
        requestBody: jsonEncode(requestBody));
    return validateResponse(response);
  }

  Future<ApiResponse> saveSettings(String fcmToken, String lang) async {
    Map requestBody = {"fcmToken": fcmToken, "lang": lang};
    String token = UserSession.instance.token;

    var response = await httpRequest.sendPost(
      contentType: 'application/json',
      token: 'Bearer ' + token,
      uri: getFullPath('/api/Home/SettingUser'),
      requestBody: jsonEncode(requestBody),
    );
    return validateResponse(response);
  }
}
