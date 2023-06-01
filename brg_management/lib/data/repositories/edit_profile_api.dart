import 'dart:convert';

import 'package:brg_management/configs/base_api.dart';
import 'package:brg_management/data/model/account_info_model.dart';
import 'package:brg_management/data/local/user_session.dart';

class EditProfileApi extends BaseApi {
  Future getAccountInfo() async {
    var response = await httpRequest.sendGet(
      token: "Bearer ${UserSession.instance.token}",
      uri: getFullPath('/api/Account/GetAccountInfo'),
    );
    return validateResponse(response);
  }

  Future checkGolfBrgCard(String cardNumber, String fullName) async {
    var request = {
      "cardNumber": cardNumber,
      "fullname": fullName,
    };
    var response = await httpRequest.sendGet(
      token: "Bearer ${UserSession.instance.token}",
      uri: getFullPath('/api/Account/CheckGoflBrgCard',
          queryParameters: request),
    );
    return validateResponse(response);
  }

  Future updateUser(AccountInfo accountInfo) async {
    var request = jsonEncode(accountInfo);
    var response = await httpRequest.sendPost(
      token: "Bearer ${UserSession.instance.token}",
      requestBody: request,
      contentType: "application/json",
      uri: getFullPath('/api/Account/Update'),
    );
    return validateResponse(response);
  }
}
