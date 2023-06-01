import 'dart:convert';

import 'package:brg_management/configs/app_config.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/configs/router.dart';
import 'package:brg_management/core/helpers/httpUtils.dart';
import 'package:brg_management/core/utils/funtion.dart';
import 'package:brg_management/core/utils/screen_util.dart';
import 'package:brg_management/data/local/user_session.dart';
import 'package:brg_management/data/model/response.dart';
import 'package:brg_management/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../common/dialog/popup_notif.dart';

abstract class BaseApi {
  String apiEndpoint = AppConfig.instance.apiEndpoint;
  String apiEndpointBookings = AppConfig.instance.apiEndpointBooking;
  HttpRequest httpRequest = HttpRequest();

  Uri getFullPath(String fullPath, {Map<String, dynamic>? queryParameters}) {
    Uri result;
    result = Uri.https(apiEndpoint, fullPath, queryParameters);
    return result;
  }

  Uri getFullPathAuth(String fullPath,
      {Map<String, dynamic>? queryParameters}) {
    Uri result;
    result = Uri.https(apiEndpointBookings, fullPath, queryParameters);
    return result;
  }

  Future<ApiResponse> validateResponse(
    response,
  ) async {
    bool success = false;
    bool fromSpecialError = false;
    if (response == null) {
      showAlertDialog(
          content: BaseApi.convertMsgCodeToMessage('system_error'),
          context: Get.context!,
          defaultActionText:
              AppLocalizations.of(Get.context!)!.translate('close'));
      return ApiResponse(
        success: success,
        fromSpecialError: fromSpecialError,
        statusCode: 500,
      );
    }
    switch (response.statusCode) {
      case 200:
        {
          success = true;
          break;
        }
      case 12029:
        fromSpecialError = true;
        {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(Get.context!)!.translate('no_internet'),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          break;
        }
      case 404:
        // not found
        fromSpecialError = true;
        {
          Fluttertoast.showToast(
              msg: BaseApi.convertMsgCodeToMessage('404'),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          break;
        }
      case 401:
        // expireToken
        fromSpecialError = true;
        {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(
                      NavigationService.navigatorKey.currentContext!)!
                  .translate("session_expire"),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          logOutClient(NavigationService.navigatorKey.currentContext!);
          break;
        }
      case 407:
        // timeOut
        fromSpecialError = true;
        {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(Get.context!)!.translate('timeout'),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          break;
        }
      case 408:
        // cannot connect to host
        fromSpecialError = true;
        // {
        //   Fluttertoast.showToast(
        //       msg: BaseApi.convertMsgCodeToMessage('408'),
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.CENTER,
        //       timeInSecForIosWeb: 1,
        //       backgroundColor: Colors.green,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        // }
        break;

      case 502:
        // non existed link
        fromSpecialError = true;
        {
          Fluttertoast.showToast(
              msg: BaseApi.convertMsgCodeToMessage('502'),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          break;
        }
    }

    var responseObject;
    var responseBody;
    var responseHeader;
    var responseBodyByte;

    if (!fromSpecialError) {
      try {
        // http.Response
        responseBody = response.body;
        responseHeader = response.headers;
        responseBodyByte = response.bodyBytes;
        responseObject = json.decode(utf8.decode(response.bodyBytes));
      } catch (ex) {
        // http.StreamedResponse
        try {
          responseBody = await response.stream.bytesToString();
          responseObject = json.decode(responseBody);
        } catch (ex) {
          // in case png bodyByte
          debugPrint(ex.toString());
        }
      }
    }

    ApiResponse result = ApiResponse(
        success: success,
        fromSpecialError: fromSpecialError,
        statusCode: response.statusCode,
        responseBody: responseBody,
        responseObject: responseObject,
        responseHeader: responseHeader,
        responseBodyByte: responseBodyByte);
    debugPrint(responseObject.toString());
    return result;
  }

  static String convertMsgCodeToMessage(String? msgCode) {
    String defaultMessage =
        AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
            .translate("system_error");
    if (msgCode == null) return defaultMessage;
    if (UserSession.instance.currentLanguage == 'vi') {
      return (UserSession.instance.vnMessages)[msgCode] ?? defaultMessage;
    } else {
      return (UserSession.instance.enMessages)[msgCode] ?? defaultMessage;
    }
  }

  static String convertMsgCodeToMessageWithParam(
      String text, dynamic msgParams) {
    final List<String> placeHolders = [];
    print("msgParams $msgParams");
    msgParams.forEach((e) => placeHolders.add(e.toString()));
    final String actual = text.format(placeHolders);
    return actual;
  }

  void logOutClient(BuildContext context) {
    UserSession.instance.token = '';
    // sharedPreferences.remove("user_name");
    // sharedPreferences.remove("pw");
    // sharedPreferences.remove("active_biometric");
    ScreenUtils.openScreenAndRemoveUtil(context, AppRouter.login);
    logoutSever();
  }

  logoutSever() async {
    String token = UserSession.instance.token;

    var request = jsonEncode({
      "LogoutId": token,
    });
    debugPrint(UserSession.instance.token);
    httpRequest.sendPost(
      notShowLoading: true,
      requestBody: request,
      token: "Bearer ${UserSession.instance.token}",
      contentType: "application/json",
      uri: getFullPathAuth('/api/account/LogoutMobile'),
    );
  }
}
