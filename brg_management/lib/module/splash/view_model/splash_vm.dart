import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:brg_management/common/dialog/popup_notif.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/shared_preferences/preferences.dart';
import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/data/local/user_session.dart';
import 'package:brg_management/data/model/base_response_api.dart';
import 'package:brg_management/data/model/check_update_message.dart';
import 'package:brg_management/data/model/response.dart';
import 'package:brg_management/data/repositories/splash_api.dart';
import 'package:brg_management/main.dart';
import 'package:flutter/material.dart';
import 'package:open_store/open_store.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashViewModel extends ChangeNotifier {
  SplashApi api = SplashApi();

  void initData() async {
    //checkVersionApp();
  }

  void updateMessage(int time) async {
    if (await SharedPreferences.instance.currentLanguage == null ||
        await SharedPreferences.instance.currentLanguage == 'vi') {
      UserSession.instance.currentLanguage = "vi";
    } else {
      UserSession.instance.currentLanguage = "en";
    }
    bool isFirstLaunch =
        await SharedPreferences.instance.isFirstLaunch == null ||
            await SharedPreferences.instance.isFirstLaunch;
    String? messageEnVersion =
        await SharedPreferences.instance.getMessageEnVersion;
    String? messageVnVersion =
        await SharedPreferences.instance.getMessageVnVersion;
    // if (messageEnVersion == null) {
    //   saveMessage("en", AppConfig.instance.messageEn);
    // } else if (messageVnVersion == null) {
    //   saveMessage("vn", AppConfig.instance.messageVn);
    // }
    if (isFirstLaunch) {
      await SharedPreferences.instance.setFirstLaunch(false);
      //getMessage("en").then((value) => saveMessage("en", value ?? ""));
      //getMessage("vn").then((value) => saveMessage("vn", value ?? ""));
      // final result = await Future.wait([getMessage("en"), getMessage("vn")]);
      // saveMessage("en", result[0] ?? "");
      // saveMessage("vn", result[1] ?? "");
    } else {
      Map<dynamic, dynamic> enMessages =
          await SharedPreferences.instance.getEnMessages();
      UserSession.instance.enMessages.addAll(enMessages);
      Map<dynamic, dynamic> vnMessages =
          await SharedPreferences.instance.getVnMessages();
      UserSession.instance.vnMessages.addAll(vnMessages);
      //checkUpdateContentMessage();
    }
    // await Future.delayed(Duration(seconds: time));
    // ScreenUtils.openScreenAndRemoveUtil(
    //     NavigationService.navigatorKey.currentContext!, AppRouter.login);
  }

  void checkVersionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String platform = Platform.isAndroid ? "1" : "0";
    String version = packageInfo.version;
    ApiResponse? apiResponse = await api.checkVersionApp(platform, version);
    if (apiResponse == null || !apiResponse.success) {
      //updateMessage(2);
      return;
    }
    if ((apiResponse.responseObject["isSuccess"] ?? false)) {
      final data = BaseResponseApi<String?>.fromJson(apiResponse.responseObject,
          compileData: (data) => !isEmpty(apiResponse.responseObject['data'])
              ? apiResponse.responseObject['data'].toString()
              : null);
      if (data.data == "1") {
        showAlertDialog(
            content: AppLocalizations.of(
                    NavigationService.navigatorKey.currentContext!)!
                .translate('content_update_version'),
            context: NavigationService.navigatorKey.currentContext!,
            onPressed: () {
              OpenStore.instance.open(
                  appStoreId: "6443689838",
                  androidAppBundleId: "com.brg.brgmanagementandroid");
              Navigator.of(NavigationService.navigatorKey.currentContext!)
                  .pop();
            },
            //onDismiss: () => updateMessage(0),
            defaultActionText: AppLocalizations.of(
                    NavigationService.navigatorKey.currentContext!)!
                .translate('update'),
            cancelActionText: AppLocalizations.of(
                    NavigationService.navigatorKey.currentContext!)!
                .translate('no'));
      } else if (data.data == "2") {
        showAlertDialog(
          content: AppLocalizations.of(
                  NavigationService.navigatorKey.currentContext!)!
              .translate('content_update_version'),
          context: NavigationService.navigatorKey.currentContext!,
          onPressed: () {
            OpenStore.instance.open(
                appStoreId: "6443689838",
                androidAppBundleId: "com.brg.brgmanagementandroid");
            Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
          },
          //onDismiss: () => updateMessage(0),
          defaultActionText: AppLocalizations.of(
                  NavigationService.navigatorKey.currentContext!)!
              .translate('update'),
        );
      } else {
        //updateMessage(1);
      }
    }
  }

  Future<String?> getMessage(String lang) async {
    ApiResponse apiResponse = await api.getMessage(lang);
    if (!apiResponse.success) return null;
    if ((apiResponse.responseObject["isSuccess"] ?? false) &&
        !isEmpty(apiResponse.responseObject["data"])) {
      return apiResponse.responseObject["data"];
    }
    return null;
  }

  Future<void> checkUpdateContentMessage() async {
    ApiResponse? apiResponse = await api.checkUpdateContentMessage();
    if (apiResponse == null || !apiResponse.success) {
      return;
    }
    if ((apiResponse.responseObject["isSuccess"] ?? false)) {
      final data = BaseResponseApi<CheckUpdateMessage>.fromJson(
          apiResponse.responseObject,
          compileData: (data) => !isEmpty(apiResponse.responseObject['data'])
              ? CheckUpdateMessage.fromJson(apiResponse.responseObject['data'])
              : null);
      handleUpdateContentMessageIfNeeded(data);
    }
  }

  void handleUpdateContentMessageIfNeeded(
      BaseResponseApi<CheckUpdateMessage> data) async {
    String? messageEnVersion =
        await SharedPreferences.instance.getMessageEnVersion;
    String? messageVnVersion =
        await SharedPreferences.instance.getMessageVnVersion;
    bool needUpdateMessageEn = (data.data.messageEn ?? false) &&
        messageEnVersion != data.data.messageEnVersion;
    bool needUpdateMessageVn = (data.data.messageVn ?? false) &&
        messageVnVersion != data.data.messageVnVersion;
    if (needUpdateMessageEn) {
      // saveMessage("en", await getMessage("en") ?? "");
      getMessage("en").then((value) => saveMessage("en", value ?? ""));
    }
    if (needUpdateMessageVn) {
      // saveMessage("vn", await getMessage("vn") ?? "");
      getMessage("vn").then((value) => saveMessage("vn", value ?? ""));
    }
    await SharedPreferences.instance
        .setMessageVnVersion(data.data.messageVnVersion);
    await SharedPreferences.instance
        .setMessageEnVersion(data.data.messageEnVersion);
  }

  void saveMessage(String lang, String messages) async {
    if (lang == "en" && !isEmpty(messages)) {
      UserSession.instance.enMessages.addAll(jsonDecode(messages));
      await SharedPreferences.instance.setEnMessages(messages);
    } else if (lang == "vn" && !isEmpty(messages)) {
      UserSession.instance.vnMessages.addAll(jsonDecode(messages));
      await SharedPreferences.instance.setVnMessages(messages);
    }
  }
}
