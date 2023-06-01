import 'dart:convert';

import 'package:brg_management/configs/base_api.dart';
import 'package:flutter/cupertino.dart';

import '../local/user_session.dart';

class LogoutApi extends BaseApi {
  Future logout() async {
    String token = UserSession.instance.token;

    var request = jsonEncode({
      "LogoutId": token,
    });
    debugPrint(UserSession.instance.token);
    var response = await httpRequest.sendPost(
      notShowLoading: true,
      requestBody: request,
      token: "Bearer ${UserSession.instance.token}",
      contentType: "application/json",
      uri: getFullPathAuth('/api/account/LogoutMobile'),
    );
    return validateResponse(response);
  }
}
