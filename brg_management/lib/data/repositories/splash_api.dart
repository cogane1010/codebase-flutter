import 'dart:convert';

import 'package:brg_management/configs/base_api.dart';
import 'package:brg_management/data/local/user_session.dart';

class SplashApi extends BaseApi {
  Future getMessage(String lang) async {
    var request = {"lang": lang};
    var response = await httpRequest.sendGet(
      notShowLoading: true,
      token: "Bearer ${UserSession.instance.token}",
      uri: getFullPath('/api/Home/GetMessageError', queryParameters: request),
    );
    return validateResponse(response);
  }

  Future checkUpdateContentMessage() async {
    var response = await httpRequest.sendGet(
      notShowLoading: true,
      token: "Bearer ${UserSession.instance.token}",
      uri: getFullPath('/api/Home/CheckUpdateContentMessage'),
    );
    return validateResponse(response);
  }

  Future checkVersionApp(String platform, String version) async {
    var request = {"platform": platform, "currVer": version};
    var response = await httpRequest.sendGet(
      notShowLoading: true,
      token: "Bearer ${UserSession.instance.token}",
      uri: getFullPath('/api/Home/CheckVersionApp', queryParameters: request),
    );
    return validateResponse(response);
  }
}
