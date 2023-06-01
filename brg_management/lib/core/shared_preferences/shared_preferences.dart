import 'dart:convert';

import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'base_preferences.dart';

class SharedPreferences extends BasePreference {
  static final SharedPreferences _instance = SharedPreferences._internal();

  static SharedPreferences get instance => _instance;

  SharedPreferences._internal();

  Future setUsername(String accessToken) => setValue("user_name", accessToken);

  Future<dynamic> get username => getValue("user_name");

  Future setPw(String accessToken) => setValue("pw", accessToken);

  Future<dynamic> get pw => getValue("pw");

  Future setLanguage(String locale) => setValue("currentLanguage", locale);

  Future<dynamic> get currentLanguage => getValue("currentLanguage");

  Future setActiveLoginBiometric(bool isActive, String username) =>
      setValue("active_biometric" + username, isActive);

  // Future<dynamic> get activeBiometric(String email) => getValue("active_biometric" + email);

  Future<bool> getActiveBiometric(String username) async {
    bool isActive = false;
    final storage = new FlutterSecureStorage();
    // String? username = await storage.read(key: 'usn');
    isActive = await getValue("active_biometric" + username) ?? false;
    return isActive;
  }

  Future setFirstLaunch(bool isActive) => setValue("first_launch", isActive);

  Future<dynamic> get isFirstLaunch => getValue("first_launch");

  Future setMessageVnVersion(String? messageVnVersion) =>
      setValue("message_vn_version", messageVnVersion);

  Future<dynamic> get getMessageVnVersion => getValue("message_vn_version");

  Future setMessageEnVersion(String? messageEnVersion) =>
      setValue("message_en_version", messageEnVersion);

  Future<dynamic> get getMessageEnVersion => getValue("message_en_version");

  Future setEnMessages(String enMessages) => setValue("en_message", enMessages);

  Future<Map<dynamic, dynamic>> getEnMessages() async {
    Map<dynamic, dynamic> enMessages = {};
    if (!isEmpty(await getValue("en_message"))) {
      enMessages.addAll(jsonDecode(await getValue("en_message")));
    }
    return enMessages;
  }

  Future setVnMessages(String vnMessages) => setValue("vn_message", vnMessages);

  Future<Map<dynamic, dynamic>> getVnMessages() async {
    Map<dynamic, dynamic> enMessages = {};
    if (!isEmpty(await getValue("vn_message"))) {
      enMessages.addAll(jsonDecode(await getValue("vn_message")));
    }
    return enMessages;
  }
}
