import 'dart:convert';

import '../../configs/base_api.dart';
import '../local/user_session.dart';
import '../model/response.dart';

class HomeApi extends BaseApi {
  Future<ApiResponse> getHomeData() async {
    String token = UserSession.instance.token;
    print("Bearer $token");
    var response = await httpRequest.sendPost(
      token: 'Bearer ' + token,
      uri: getFullPath('/api/app/ModuleList/GetByUserName'),
    );
    print("response : " + response.toString());
    return validateResponse(response);
  }

  Future getCountTodoList(String moduleName) async {
    var request = jsonEncode({"ModuleName": moduleName});

    var response = await httpRequest.sendPost(
      requestBody: request,
      token: "Bearer ${UserSession.instance.token}",
      contentType: "application/json",
      uri: getFullPath('/api/app/TodoList/GetCountTodoList'),
    );
    return validateResponse(response);
  }
}
