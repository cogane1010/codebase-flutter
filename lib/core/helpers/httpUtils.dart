import 'dart:async';
import 'dart:io';

import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

const APP_VERSION = "app_version";
const PLATFORM = 'platform';
const OS_VERSION = 'os_version';
const CLIENT_ID = 'client_id';
const REQUEST_ID = 'request_id';
const DEVICE_TOKEN = 'device_token';

class HttpRequest {
  Future<dynamic> sendGet(
      {Uri? uri,
      String? token,
      bool? notShowLoading,
      int timeout = 60,
      Map<String, String>? headers}) async {
    debugPrint(uri.toString());
    // bool isInternet = await check();
    // if (!isInternet) {
    //   return http.Response('', 12029);
    // }
    Map<String, String> defaultHeaders = {
      HttpHeaders.contentTypeHeader:
          " application/json; x-www-form-urlencoded;charset=UTF-8",
    };
    if (!isEmpty(token)) {
      defaultHeaders[HttpHeaders.authorizationHeader] = token!;
    }
    try {
      if ((notShowLoading == null || notShowLoading == false) &&
          !EasyLoading.isShow) {
        EasyLoading.show();
      }
      http.Response response = await http
          .get(
            uri!,
            headers: headers ?? defaultHeaders,
          )
          .timeout(Duration(seconds: timeout));
      return response;
    } on TimeoutException catch (ex) {
      print(ex.message);
      return http.Response(ex.toString(), 407);
    } on Exception catch (ex) {
      debugPrint(ex.toString());
      check().then((intenet) {
        return http.Response(ex.toString(), 408);

        // No-Internet Case
      });
    } finally {
      if ((notShowLoading == null || notShowLoading == false) &&
          EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
  }

  Future<dynamic> sendPost(
      {Uri? uri,
      requestBody,
      bool? notShowLoading,
      String contentType = "application/x-www-form-urlencoded",
      Map<String, String>? customHeader,
      String? token,
      int timeout = 60}) async {
    debugPrint(uri.toString());
    debugPrint(requestBody.toString());
    // bool isInternet = await check();
    // if (!isInternet) {
    //   return http.Response('', 12029);
    // }
    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: contentType,
      };
      if (!isEmpty(token)) {
        headers[HttpHeaders.authorizationHeader] = token!;
      }
      if (!isEmpty(customHeader)) {
        headers.addAll(customHeader!);
      }
      if ((notShowLoading == null || notShowLoading == false) &&
          !EasyLoading.isShow) {
        EasyLoading.show();
      }
      http.Response response = await http
          .post(uri!, headers: headers, body: requestBody)
          .timeout(Duration(seconds: timeout));
      return response;
    } on TimeoutException catch (ex) {
      print(ex.message);
      return http.Response(ex.toString(), 407);
    } on Exception catch (ex) {
      debugPrint(ex.toString());
      return http.Response(ex.toString(), 408);
    } finally {
      if ((notShowLoading == null || notShowLoading == false) &&
          EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
  }

  Future<dynamic> sendPut(
      {Uri? uri,
      bool? notShowLoading,
      String? requestBody,
      String? token,
      int timeout = 30}) async {
    debugPrint(uri.toString());
    debugPrint(requestBody.toString());
    // bool isInternet = await check();
    // if (!isInternet) {
    //   return http.Response('', 12029);
    // }
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json"
    };
    if (!isEmpty(token)) {
      headers[HttpHeaders.authorizationHeader] = token!;
    }

    try {
      if ((notShowLoading == null || notShowLoading == false) &&
          !EasyLoading.isShow) {
        EasyLoading.show();
      }
      http.Response response = await http
          .put(uri!, headers: headers, body: requestBody)
          .timeout(Duration(seconds: timeout));
      return response;
    } on TimeoutException catch (ex) {
      return http.Response(ex.toString(), 407);
    } catch (ex) {
      check().then((intenet) {
        return http.Response(ex.toString(), 408);

        // No-Internet Case
      });
    } finally {
      if (EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
  }

  Future<bool> check() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      print('YAY! Free cute dog pics!');
    } else {}

    return result;
  }
}
