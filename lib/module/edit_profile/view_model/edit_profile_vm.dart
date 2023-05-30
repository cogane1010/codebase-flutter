import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:brg_management/common/dialog/popup_notif.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/core/utils/utils.dart';
import 'package:brg_management/data/model/account_info_model.dart';
import 'package:brg_management/data/model/base_response_api.dart';

import 'package:brg_management/data/model/response.dart';
import 'package:brg_management/data/model/update_user_response.dart';
import 'package:brg_management/data/repositories/edit_profile_api.dart';
import 'package:brg_management/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfileViewModel extends ChangeNotifier {
  EditProfileApi api = EditProfileApi();
  static List<String> genders = [
    "Male",
    "Female",
  ];
  int genderIndex = 0;
  String birthDay = "";
  String? imagePath;
  String? imageBase64;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  AccountInfo? accountInfo;

  final List<TextEditingController> controller = [];

  void initData() {
    getAccountInfo();
  }

  void getAccountInfo() async {
    ApiResponse? apiResponse = await api.getAccountInfo();
    if (apiResponse == null || !(apiResponse.success)) {
      showAlertDialog(
          content: AppLocalizations.of(
                  NavigationService.navigatorKey.currentContext!)!
              .translate("system_error"),
          context: NavigationService.navigatorKey.currentContext!,
          defaultActionText: AppLocalizations.of(
                  NavigationService.navigatorKey.currentContext!)!
              .translate('close'));
      return;
    }
    final data = BaseResponseApi<AccountInfo>.fromJson(
        apiResponse.responseObject,
        compileData: (data) => !isEmpty(apiResponse.responseObject['data'])
            ? AccountInfo.fromJson(apiResponse.responseObject['data'])
            : null);
    accountInfo = data.data;
    usernameController.text = accountInfo?.fullName ?? "";
    emailController.text = accountInfo?.email ?? "";
    phoneController.text = accountInfo?.mobilePhone ?? "";
    birthDay = (accountInfo?.dob == null
            ? DateTimeUtils.convertToString(DateTime.now())
            : DateTimeUtils.convertToString(DateTimeUtils.convertToDateTime(
                accountInfo?.dob!,
                format: DateTimeUtils.apiFormat)!)) ??
        "";
    genderIndex = 0;
    if (accountInfo?.gender == 0) {
      genderIndex = 1;
    }
    if (!isEmpty(accountInfo?.imgUrl)) {
      imagePath =
          "https://${AppConfig.instance.apiEndpoint}/assets/Avatar/${accountInfo?.imgUrl?.substring(1)}";
    }

    notifyListeners();
  }

  void updateImagePath(String? newPath) {
    if (newPath == null) return;
    imagePath = newPath;
    notifyListeners();
  }

  void updateGender(int genderIndex, newValue) {
    if (newValue == null) return;
    this.genderIndex = genderIndex;
    notifyListeners();
  }

  void updateBirthday(DateTime? selectedDate) {
    if (selectedDate == null) return;
    birthDay = DateTimeUtils.convertToString(selectedDate) ?? "";
    notifyListeners();
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .translate('name_is_not_be_blank');
    }
    return null;
  }

  Future convertImageToBase64() async {
    if (isEmpty(imagePath) ||
        imagePath!.startsWith(
            "https://${AppConfig.instance.apiEndpoint}/assets/Avatar")) return;
    File imageFile = File(imagePath!); //convert Path to File
    Uint8List imageBytes = await imageFile.readAsBytes(); //convert to bytes
    String fileExtensionName = imageFile.path.split('.').last;
    imageBase64 = "data:image/" +
        fileExtensionName +
        ";base64," +
        base64.encode(imageBytes); //convert bytes to base64 string
  }

  void updateUser(Function updateSuccessCallback) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (usernameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(
                  NavigationService.navigatorKey.currentContext!)!
              .translate('name_is_not_be_blank'));
      return;
    }

    await convertImageToBase64();
    DateTime? apiBirthDay = DateTimeUtils.convertToDateTime(birthDay);
    AccountInfo newAccountInfo = AccountInfo();
    newAccountInfo.fullName = usernameController.text;
    newAccountInfo.email = emailController.text;
    newAccountInfo.mobilePhone = phoneController.text;
    newAccountInfo.dob = apiBirthDay == null
        ? null
        : DateTimeUtils.convertToString(apiBirthDay,
            format: DateTimeUtils.apiFormat);
    //1 là Nam, 0 là Nữ
    newAccountInfo.gender = genderIndex == 0 ? 1 : 0;
    newAccountInfo.isMember = false;
    newAccountInfo.isActive = true;

    newAccountInfo.id = accountInfo?.id;
    newAccountInfo.avatarFileId = accountInfo?.avatarFileId;
    newAccountInfo.userId = accountInfo?.userId;
    if (!isEmpty(accountInfo?.imgUrl) && isEmpty(imageBase64)) {
      newAccountInfo.imgUrl = accountInfo?.imgUrl;
    } else {
      newAccountInfo.imageData = imageBase64;
    }
    ApiResponse apiResponse = await api.updateUser(newAccountInfo);
    BaseResponseApi<UpdateUserResponse> baseResponseApi =
        BaseResponseApi<UpdateUserResponse>.fromJson(apiResponse.responseObject,
            compileData: (data) =>
                UpdateUserResponse.fromJson(apiResponse.responseObject));
    if (baseResponseApi.isSuccess ?? false) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(
                  NavigationService.navigatorKey.currentContext!)!
              .translate('update_successfully'));
      updateSuccessCallback();
      return;
    }
    Fluttertoast.showToast(msg: baseResponseApi.errorMessage.toString());
  }

  void clear() {
    imageBase64 = null;
    imagePath = null;
    controller.forEach((element) {
      element.dispose();
    });
    controller.clear();
  }
}
