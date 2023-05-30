import 'dart:convert';
import 'package:brg_management/configs/base_api.dart';
import 'package:brg_management/data/model/account_info_model.dart';

class SignInApi extends BaseApi {
  Future checkCardNumber(String fullName, String cardNumber) async {
    final cardInfoInput = {
      'cardNumber': cardNumber,
      'fullName': fullName,
    };
    var response = await httpRequest.sendGet(
      uri: getFullPath('/api/Account/CheckGoflBrgCard',
          queryParameters: cardInfoInput),
    );
    print("response : " + response.toString());
    return validateResponse(response);
  }

  Future createAccount(AccountInfo accountInfo) async {
    var request = jsonEncode(accountInfo);
    var response = await httpRequest.sendPost(
      requestBody: request,
      contentType: "application/json",
      uri: getFullPath('/api/Account/Create'),
    );
    print("response : " + response.toString());
    return validateResponse(response);

    // var data = await validateResponse(response);
    // ChangePasswordResponse result =
    // ChangePasswordResponse.fromJson(data.responseObject);
  }
}
