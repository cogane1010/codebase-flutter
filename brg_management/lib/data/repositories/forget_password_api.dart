import 'dart:convert';

import 'package:brg_management/configs/base_api.dart';

import '../model/response.dart';

class ForgetPassWord extends BaseApi {
  Future<ApiResponse> forgetPassWord(String userName) async {
    Map requestBody = {"email": userName};
    var response = await httpRequest.sendPost(
        contentType: 'application/json',
        uri: getFullPath('/api/Account/ForgotPassword'),
        requestBody: jsonEncode(requestBody));
    return validateResponse(response);
  }
}
