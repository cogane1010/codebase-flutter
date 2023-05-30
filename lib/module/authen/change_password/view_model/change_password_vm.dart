import 'package:brg_management/common/dialog/popup_notif.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/utils/validator.dart';
import 'package:brg_management/data/model/base_response_api.dart';
import 'package:brg_management/data/model/change_password_response.dart';
import 'package:brg_management/data/model/response.dart';
import 'package:brg_management/data/repositories/change_password_api.dart';
import 'package:brg_management/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  ChangePasswordApi api = ChangePasswordApi();
  var confirmable = false,
      enterNewPasswordObscure = false,
      retypeNewPasswordObscure = false;
  final enterOldPasswordController = TextEditingController();
  final enterNewPasswordController = TextEditingController();
  final retypeNewPasswordController = TextEditingController();

  void initData() {}

  void initListener() {
    enterOldPasswordController.addListener(() {
      confirmable = enterOldPasswordController.text.isNotEmpty &&
          enterNewPasswordController.text.isNotEmpty &&
          retypeNewPasswordController.text.isNotEmpty;
      notifyListeners();
    });
    enterNewPasswordController.addListener(() {
      confirmable = enterOldPasswordController.text.isNotEmpty &&
          enterNewPasswordController.text.isNotEmpty &&
          retypeNewPasswordController.text.isNotEmpty;
      notifyListeners();
    });
    retypeNewPasswordController.addListener(() {
      confirmable = enterOldPasswordController.text.isNotEmpty &&
          enterNewPasswordController.text.isNotEmpty &&
          retypeNewPasswordController.text.isNotEmpty;
      notifyListeners();
    });
  }

  validateInput() async {
    String? message;
    if (!validatePassword(enterNewPasswordController.text)) {
      message =
          AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
              .translate('new_pw_is_not_valid');
    } else if (enterNewPasswordController.text !=
        retypeNewPasswordController.text) {
      message =
          AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
              .translate('confirm_pw_is_not_exact');
    }
    return message;
  }

  Future changePassword() async {
    String oldPassword = enterOldPasswordController.text;
    String newPassword = enterNewPasswordController.text;
    String confirmPassword = retypeNewPasswordController.text;
    ApiResponse apiResponse =
        await api.changePassword(oldPassword, newPassword, confirmPassword);
    print(apiResponse.success);
    if (!apiResponse.success) {
      return;
    }
    BaseResponseApi<ChangePasswordResponse> result = BaseResponseApi.fromJson(
        apiResponse.responseObject,
        compileData: (data) =>
            ChangePasswordResponse.fromJson(apiResponse.responseObject));
    return result;
  }

  Future<BaseResponseApi?> changePasswordNew(
      {String? oldPw, String? newPw, String? confirmPw}) async {
    String oldPassword = oldPw ?? enterOldPasswordController.text;
    String newPassword = newPw ?? enterNewPasswordController.text;
    String confirmPassword = confirmPw ?? retypeNewPasswordController.text;
    ApiResponse apiResponse =
        await api.changePassword(oldPassword, newPassword, confirmPassword);
    BaseResponseApi? dataCallback;
    if (apiResponse.success) {
      BaseResponseApi<ChangePasswordResponse> result = BaseResponseApi.fromJson(
          apiResponse.responseObject,
          compileData: (data) =>
              ChangePasswordResponse.fromJson(apiResponse.responseObject));
      if (result.isSuccess!) {
        dataCallback = result;
      } else {
        showAlertDialog(
            content: result.errorMessage ??
                AppLocalizations.of(Get.context!)!.translate("system_error"),
            context: Get.context!,
            defaultActionText:
                AppLocalizations.of(Get.context!)!.translate('close'));
      }
    }
    return dataCallback;
  }

  void updateEnterNewPasswordObscure() {
    enterNewPasswordObscure = !enterNewPasswordObscure;
    notifyListeners();
  }

  void updateRetypeNewPasswordObscure() {
    retypeNewPasswordObscure = !retypeNewPasswordObscure;
    notifyListeners();
  }

  void clear() {
    enterOldPasswordController.clear();
    enterNewPasswordController.clear();
    retypeNewPasswordController.clear();
  }
}
