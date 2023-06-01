import 'dart:convert';

import 'package:brg_management/configs/base_api.dart';
import 'package:brg_management/data/local/user_session.dart';

class ChangePasswordApi extends BaseApi {
  Future changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    var request = jsonEncode({
      "oldPassword": oldPassword,
      "password": newPassword,
      "confirmPassword": confirmPassword,
    });
    print(UserSession.instance.token);
    var response = await httpRequest.sendPost(
      requestBody: request,
      token: "Bearer ${UserSession.instance.token}",
      contentType: "application/json",
      uri: getFullPath('/api/Account/ChangePassword'),
    );
    return validateResponse(response);
  }
}
