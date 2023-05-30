import 'dart:io';

import 'package:brg_management/common/dialog/dialog_utils.dart';
import 'package:brg_management/common/widget/base_background.dart';
import 'package:brg_management/common/widget/base_button.dart';
import 'package:brg_management/common/widget/base_text_field.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/helpers/ui_helper.dart';
import 'package:brg_management/core/utils/date_time.dart';
import 'package:brg_management/core/utils/screen_util.dart';
import 'package:brg_management/core/utils/theme_util.dart';
import 'package:brg_management/module/authen/sign_in/view_model/sign_in_vm.dart';
import 'package:brg_management/resources/asset_image.dart';
import 'package:brg_management/resources/color.dart';
import 'package:brg_management/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var viewModel;
  final formSignInKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      viewModel = Provider.of<SignInViewModel>(context, listen: false);
      viewModel.initListener();
      formSignInKey.currentState!.reset();
    });
    super.initState();
  }

  @override
  void dispose() {
    viewModel.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.appBarColor,
          title: Text(AppLocalizations.of(context)!.translate("sign_up")),
          leading: GestureDetector(
              onTap: () {
                viewModel.clear();
                ScreenUtils.closeScreen(context);
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: Container(
          child: Consumer<SignInViewModel>(
            builder: (context, vm, child) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/png/bg_screen.png",
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomLeft,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: UiHelper.edgeInsetAll24,
                      child: Form(
                        key: formSignInKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // avatar
                            buildSelectPhotoWidget(context, vm),

                            // full name
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("full_name"),
                                style: textStyleNormalTitle,
                              ),
                            ),
                            UiHelper.verticalBox8,
                            BaseTextField(
                              maxLength: 100,
                              validator: (value) =>
                                  vm.validateName(value!, context),
                              controller: vm.nameController,
                              style: textStyleSmallContent,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                contentPadding: UiHelper.horizontalEdge8,
                              ),
                            ),

                            UiHelper.verticalBox16,

                            // email
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("email"),
                                style: textStyleNormalTitle,
                              ),
                            ),
                            UiHelper.verticalBox8,
                            BaseTextField(
                              maxLength: 150,
                              validator: (value) =>
                                  vm.validEmail(value!, context),
                              controller: vm.emailController,
                              style: textStyleSmallContent,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                contentPadding: UiHelper.horizontalEdge8,
                              ),
                            ),

                            UiHelper.verticalBox16,

                            // phone number
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("phone_number"),
                                style: textStyleNormalTitle,
                              ),
                            ),
                            UiHelper.verticalBox8,
                            BaseTextField(
                              maxLength: 14,
                              controller: vm.phoneController,
                              validator: (value) =>
                                  vm.validPhone(value!, context),
                              style: textStyleSmallContent,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                contentPadding: UiHelper.horizontalEdge8,
                              ),
                            ),

                            UiHelper.verticalBox16,

                            //birthday
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("birthday"),
                                style: textStyleNormalTitle,
                              ),
                            ),
                            UiHelper.verticalBox8,
                            buildBirthDayWidget(context, vm),

                            UiHelper.verticalBox16,

                            //gender
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("gender"),
                                style: textStyleNormalTitle,
                              ),
                            ),
                            UiHelper.verticalBox8,
                            buildGenderWidget(context, vm),

                            UiHelper.verticalBox16,

                            //password
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("password"),
                                style: textStyleNormalTitle,
                              ),
                            ),
                            UiHelper.verticalBox8,
                            BaseTextField(
                              maxLength: 29,
                              obscureText: true,
                              validator: (value) =>
                                  vm.validPassword(value!, context),
                              obscuringCharacter: '●',
                              controller: vm.passwordController,
                              style: textStyleSmallContent,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                border: InputBorder.none,
                                counterText: "",
                                contentPadding: UiHelper.horizontalEdge8,
                              ),
                            ),

                            UiHelper.verticalBox16,

                            // retype password
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate("retype_password"),
                                style: textStyleNormalTitle,
                              ),
                            ),
                            UiHelper.verticalBox8,
                            BaseTextField(
                              maxLength: 29,
                              obscureText: true,
                              validator: (value) =>
                                  vm.validRetypePassword(value!, context),
                              obscuringCharacter: '●',
                              controller: vm.retypePasswordController,
                              style: textStyleSmallContent,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                border: InputBorder.none,
                                counterText: "",
                                contentPadding: UiHelper.horizontalEdge8,
                              ),
                            ),

                            UiHelper.verticalBox8,
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .translate("have_membership_already"),
                                  style: textStyleNormalTitle,
                                )),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Transform.translate(
                                      offset: Offset(-16, 0),
                                      child: Text(AppLocalizations.of(context)!
                                          .translate("yes")),
                                    ),
                                    leading: Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => AppColors.appBarColor),
                                      value: HaveMembership.yes,
                                      groupValue: vm.isMembership,
                                      onChanged: (HaveMembership? value) {
                                        vm.updateMembership(value);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Transform.translate(
                                      offset: Offset(-16, 0),
                                      child: Text(AppLocalizations.of(context)!
                                          .translate("no")),
                                    ),
                                    leading: Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => AppColors.appBarColor),
                                      value: HaveMembership.no,
                                      groupValue: vm.isMembership,
                                      onChanged: (HaveMembership? value) {
                                        vm.updateMembership(value);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            UiHelper.verticalBox8,
                            _buildConfirmWidget(context, vm),
                            UiHelper.verticalBox48,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildSelectPhotoWidget(BuildContext context, SignInViewModel vm) {
    return Align(
        alignment: Alignment.center,
        child: Material(
            type: MaterialType.transparency,
            //Makes it usable on any background color, thanks @IanSmith
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                  //This keeps the splash effect within the circle
                  borderRadius: BorderRadius.circular(1000.0),
                  //Something large to ensure a circle
                  onTap: () async {
                    await showSelectPhotoDialog(context,
                        handlePickedFile: (path) {
                      vm.updateImagePath(path);
                    });
                  },
                  child: Container(
                    padding: vm.imagePath == null
                        ? EdgeInsets.all(40.0)
                        : EdgeInsets.zero,
                    child: vm.imagePath == null
                        ? SvgPicture.asset(
                            'assets/svg/ic_take_photo.svg',
                            color: AppColors.settingIconColor,
                          )
                        : CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000.0),
                                child: Image.file(
                                  File(vm.imagePath!),
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                )),
                          ),
                  )),
            )));
  }

  buildBirthDayWidget(BuildContext context, SignInViewModel vm) {
    return GestureDetector(
      onTap: () async {
        final selectedDate = DateTimeUtils.convertToDateTime(vm.birthDay);
        var dateTime = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(dateTime.year - 100),
          lastDate: dateTime,
        );
        vm.updateBirthday(picked);
      },
      child: BaseBackground(
        width: double.infinity,
        height: Dimens.size48,
        borderColor: Colors.grey,
        backgroundColor: Colors.white,
        padding: EdgeInsets.all(Dimens.size8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(vm.birthDay),
            SvgPicture.asset(
              ic_event,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  buildGenderWidget(BuildContext context, SignInViewModel vm) {
    final genders = SignInViewModel.genders
        .map((value) =>
            AppLocalizations.of(context)!.translate(value.toLowerCase()))
        .toList();
    return BaseBackground(
      width: double.infinity,
      height: Dimens.size48,
      borderColor: Colors.grey,
      backgroundColor: Colors.white,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            value: genders[vm.genderCode],
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            style: textStyleSmallContent,
            onChanged: (String? newValue) {
              vm.updateGender(
                  newValue, genders.indexOf(newValue ?? genders.first));
            },
            items: genders
                .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                .toList(),
          ),
        ),
      ),
    );
  }

  _buildConfirmWidget(BuildContext context, SignInViewModel vm) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BaseButton(
        onPressed: () {
          if (formSignInKey.currentState!.validate()) {
            vm.createAccount(context);
          }
        },
        style: textStyleWhiteBoldTitle,
        lineColor: AppColors.settingIconColor,
        textColor: AppColors.whiteColor,
        backgroundColor: AppColors.settingIconColor,
        text: AppLocalizations.of(context)!.translate('confirm').toUpperCase(),
      ),
    );
  }
}
