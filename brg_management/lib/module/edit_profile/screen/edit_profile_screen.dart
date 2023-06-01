import 'dart:io';

import 'package:brg_management/common/dialog/dialog_utils.dart';
import 'package:brg_management/common/widget/base_background.dart';
import 'package:brg_management/common/widget/base_text_field.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/helpers/ui_helper.dart';
import 'package:brg_management/core/utils/screen_util.dart';
import 'package:brg_management/core/utils/theme_util.dart';
import 'package:brg_management/core/utils/utils.dart';

import 'package:brg_management/module/edit_profile/view_model/edit_profile_vm.dart';
import 'package:brg_management/resources/asset_image.dart';
import 'package:brg_management/resources/color.dart';
import 'package:brg_management/resources/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var viewModel;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      viewModel = Provider.of<EditProfileViewModel>(context, listen: false);
      viewModel.initData();
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
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              ScreenUtils.closeScreen(context);
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),
          title: Text(AppLocalizations.of(context)!.translate("edit_profile")),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg_tmp),
              fit: BoxFit.cover,
            ),
          ),
          child: Consumer<EditProfileViewModel>(
            builder: (context, vm, child) {
              return Stack(children: [
                SingleChildScrollView(
                  child: Container(
                    margin: UiHelper.edgeInsetAll24,
                    child: Form(
                      key: vm.formKey,
                      child: Column(
                        children: [
                          UiHelper.verticalBox16,
                          buildSelectPhotoWidget(context, vm),
                          UiHelper.verticalBox16,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.translate("email"),
                              style: textStyleNormalTitle,
                            ),
                          ),
                          UiHelper.verticalBox8,
                          BaseTextField(
                            backgroundColor: Colors.grey.shade200,
                            controller: vm.emailController,
                            enable: false,
                            maxLength: 255,
                            style: textStyleTinyContent,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              contentPadding: UiHelper.horizontalEdge8,
                            ),
                          ),
                          UiHelper.verticalBox16,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate("username"),
                              style: textStyleNormalTitle,
                            ),
                          ),
                          UiHelper.verticalBox8,
                          UiHelper.verticalBox16,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.translate("phone"),
                              style: textStyleNormalTitle,
                            ),
                          ),
                          UiHelper.verticalBox8,
                          BaseTextField(
                            backgroundColor: Colors.grey.shade200,
                            controller: vm.phoneController,
                            enable: false,
                            maxLength: 14,
                            style: textStyleTinyContent,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              contentPadding: UiHelper.horizontalEdge8,
                            ),
                          ),
                          UiHelper.verticalBox16,
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.translate("gender"),
                              style: textStyleNormalTitle,
                            ),
                          ),
                          UiHelper.verticalBox8,
                          buildGenderWidget(context, vm),
                          UiHelper.verticalBox8,
                          UiHelper.verticalBox8,
                          buildConfirmWidget(context, vm),
                        ],
                      ),
                    ),
                  ),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }

  buildSelectPhotoWidget(BuildContext context, EditProfileViewModel vm) {
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
                                child: vm.imagePath!.startsWith(
                                        "https://${AppConfig.instance.apiEndpoint}/assets/Avatar")
                                    ? Image.network(
                                        vm.imagePath!,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      )
                                    : Image.file(
                                        File(vm.imagePath!),
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      )),
                          ),
                  )),
            )));
  }

  buildGenderWidget(BuildContext context, EditProfileViewModel vm) {
    final genders = EditProfileViewModel.genders
        .map((value) =>
            AppLocalizations.of(context)!.translate(value.toLowerCase()))
        .toList();
    return BaseBackground(
      width: double.infinity,
      height: Dimens.size48,
      padding: UiHelper.horizontalEdge8,
      borderColor: Colors.grey,
      backgroundColor: Colors.white,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: genders[vm.genderIndex],
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down),
          onChanged: (String? newValue) {
            vm.updateGender(
                genders.indexOf(newValue ?? genders.first), newValue);
          },
          items: genders
              .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: textStyleTinyContent,
                        ),
                      ))
              .toList(),
        ),
      ),
    );
  }

  buildBirthDayWidget(BuildContext context, EditProfileViewModel vm) {
    return GestureDetector(
      onTap: () async {
        final selectedDate = DateTimeUtils.convertToDateTime(vm.birthDay);
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 100),
          lastDate: DateTime.now(),
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
            Text(
              vm.birthDay,
              style: textStyleTinyContent,
            ),
            SvgPicture.asset(ic_event)
          ],
        ),
      ),
    );
  }

  buildConfirmWidget(BuildContext context, EditProfileViewModel vm) {
    return GestureDetector(
      onTap: () {
        vm.updateUser(() {
          ScreenUtils.closeScreen(context);
        });
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(bottom: Dimens.size10),
        child: BaseBackground(
          topLeftRadius: Radius.circular(Dimens.size12),
          bottomRightRadius: Radius.circular(Dimens.size12),
          height: Dimens.size45,
          borderColor: AppColors.settingIconColor,
          backgroundColor: AppColors.settingIconColor,
          child: Text(
            AppLocalizations.of(context)!.translate('confirm').toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: textStyleWhiteSmallContent,
          ),
        ),
      ),
    );
  }
}
