import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/configs/base_api.dart';
import 'package:brg_management/core/utils/date_time.dart';
import 'package:brg_management/core/utils/validator.dart';
import 'package:brg_management/data/model/account_info_model.dart';

import 'package:brg_management/data/model/response.dart';
import 'package:brg_management/data/repositories/sign_in_api.dart';
import 'package:brg_management/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum HaveMembership { yes, no }

class SignInViewModel extends ChangeNotifier {
  SignInApi api = SignInApi();

  static List<String> genders = [
    "Female", // 1 Nam, 0 Nữ
    "Male",
  ];
  String? gender;
  int genderCode = 1;
  String birthDay = DateTimeUtils.convertToString(DateTime.now())!;
  String? imagePath;
  String? imageBase64;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();
  final cardNumberController = TextEditingController();

  final List<TextEditingController> controller = [];

  HaveMembership? isMembership = HaveMembership.no;

  void initListener() {}

  void clear() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    retypePasswordController.clear();
    cardNumberController.clear();
    isMembership = HaveMembership.no;
    controller.clear();

    gender = null;
    genderCode = 1;
    birthDay = DateTimeUtils.convertToString(DateTime.now())!;
    imagePath = null;
    imageBase64 = null;
  }

  void updateBirthday(DateTime? selectedDate) {
    if (selectedDate == null) return;
    birthDay = DateTimeUtils.convertToString(selectedDate) ?? "";
    notifyListeners();
  }

  void updateGender(String? newValue, int genderCode) {
    if (newValue == null) return;
    gender = newValue;
    this.genderCode = genderCode;
    notifyListeners();
  }

  void updateImagePath(String? newPath) {
    if (newPath == null) return;
    imagePath = newPath;
    convertImageToBase64(imagePath);
    notifyListeners();
  }

  Future convertImageToBase64(String? imagePath) async {
    File imageFile = File(imagePath!); //convert Path to File
    Uint8List imageBytes = await imageFile.readAsBytes(); //convert to bytes
    String fileExtensionName = imageFile.path.split('.').last;
    imageBase64 = "data:image/" +
        fileExtensionName +
        ";base64," +
        base64.encode(imageBytes); //convert bytes to base64 string
  }

  void updateMembership(HaveMembership? value) {
    if (value == null) return;
    isMembership = value;
    if (isMembership == HaveMembership.yes) {
      controller.clear();
    }
    notifyListeners();
  }

  String? validateName(String value, BuildContext context) {
    if (value.isEmpty) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .translate('name_is_not_be_blank');
    }
    return null;
  }

  String? validEmail(String value, BuildContext context) {
    if (!validateEmail(value.trim())) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .translate('invalid_email');
    }
    return null;
  }

  String? validPhone(String value, BuildContext context) {
    if (value.isEmpty || value.length < 8) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .translate('phone_number_is_not_be_blank');
    }
    return null;
  }

  String? validPassword(String value, BuildContext context) {
    if (!validatePassword(value) || value.length < 8) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .translate('pw_pattern_not_match');
    }
    return null;
  }

  String? validRetypePassword(String value, BuildContext context) {
    if (passwordController.text != retypePasswordController.text) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .translate('retype_pw_not_match');
    }
    return null;
  }

  void createAccount(BuildContext context) async {
    AccountInfo accountInfo = new AccountInfo();
    accountInfo.fullName = nameController.text;
    accountInfo.email = emailController.text;
    accountInfo.mobilePhone = phoneController.text;
    DateTime? apiBirthDay = DateTimeUtils.convertToDateTime(birthDay);
    accountInfo.dob = DateTimeUtils.convertToString(apiBirthDay,
            format: DateTimeUtils.apiFormat)
        .toString();
    accountInfo.gender = genderCode;
    accountInfo.password = passwordController.text;
    accountInfo.confirmPassword = passwordController.text;
    accountInfo.isMember = false;
    accountInfo.isActive = true;
    accountInfo.id = "00000000-0000-0000-0000-000000000000";
    accountInfo.avatarFileId = "00000000-0000-0000-0000-000000000000";
    accountInfo.userId = "00000000-0000-0000-0000-000000000000";
    accountInfo.imageData = imageBase64;
    accountInfo.isSendOtp = false;
    ApiResponse response = await api.createAccount(accountInfo);
    Map<String, dynamic> baseResponseMap = jsonDecode(response.responseBody);
    var msgCode = baseResponseMap['msgCode'];
    var isSuccess = baseResponseMap['isSuccess'];

    if (isSuccess) {
    } else {
      Fluttertoast.showToast(
          msg: BaseApi.convertMsgCodeToMessage(msgCode.toString()));
    }
  }
}
