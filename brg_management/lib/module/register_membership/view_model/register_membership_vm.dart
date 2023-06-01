import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/utils/validator.dart';
import 'package:brg_management/data/model/base_response_api.dart';

import 'package:brg_management/main.dart';
import 'package:flutter/material.dart';

import '../../../data/model/register_membership_model.dart';

class RegisterMemberShipViewModel extends ChangeNotifier {
  int golfCourseIndex = -1;
  final formKey = GlobalKey<FormState>();
  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  RegisterMembershipModel? model;
  BaseResponseApi? contactAllCourseResponse;

  bool showPhoneSupport = false;

  void initData() async {
    fullNameController.text = model?.fullName ?? "";
    phoneController.text = model?.mobilePhone ?? "";
    emailController.text = model?.email ?? "";
  }

  void updateGolfCourse(String? golfCourse, int index) {
    golfCourseIndex = index;
  }

  void showPhoneSupportDialog(bool showPhoneSupport) {
    this.showPhoneSupport = showPhoneSupport;
  }

  String? validateFullName() {
    if (fullNameController.text.isEmpty) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .translate('name_is_not_be_blank');
    }
    return null;
  }

  String? validatePhone() {
    if (phoneController.text.isEmpty || phoneController.text.length < 8) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .translate('phone_number_is_not_be_blank');
    }
    return null;
  }

  String? validateEmailValue() {
    if (!validateEmail(emailController.text)) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .translate('invalid_email');
    }
    return null;
  }

  void registerMemberShip(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
  }

  void clear() {
    fullNameController.clear();
    phoneController.clear();
    emailController.clear();
  }
}
