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

    Map<String, String> defaultHeaders = {
      HttpHeaders.contentTypeHeader:
          " application/json; x-www-form-urlencoded;charset=UTF-8",
    };
    defaultHeaders[HttpHeaders.authorizationHeader] = token!;
    try {
      http.Response response = await http
          .get(
            uri!,
            headers: headers ?? defaultHeaders,
          )
          .timeout(Duration(seconds: timeout));
      return response;
    } on Exception catch (ex) {
      debugPrint(ex.toString());
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

    try {
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: contentType,
      };
      headers[HttpHeaders.authorizationHeader] = token!;
      headers.addAll(customHeader!);

      http.Response response = await http
          .post(uri!, headers: headers, body: requestBody)
          .timeout(Duration(seconds: timeout));
      return response;
    } on Exception catch (ex) {
      debugPrint(ex.toString());
      return http.Response(ex.toString(), 408);
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

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json"
    };
    headers[HttpHeaders.authorizationHeader] = token!;

    try {
      http.Response response = await http
          .put(uri!, headers: headers, body: requestBody)
          .timeout(Duration(seconds: timeout));
      return response;
    } catch (ex) {}
  }
}
