import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/resources/asset_image.dart';
import 'package:brg_management/configs/router.dart';
import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/core/helpers/ui_helper.dart';
import 'package:brg_management/core/utils/screen_util.dart';
import 'package:brg_management/core/utils/theme_util.dart';
import 'package:brg_management/module/settings/viewmodel/setting_vm.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../common/dialog/popup_notif.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var viewModel;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      viewModel = Provider.of<SettingsViewModel>(context, listen: false);
      viewModel.initViewModel();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg_tmp),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<SettingsViewModel>(
          builder: (context, vm, child) {
            return Column(
              children: [
                UiHelper.verticalBox4,
                buildEditProfileWidget(context, vm),
                Divider(),
                buildChangePasswordWidget(context, vm),
                Divider(),
                buildSettingBiometricWidget(context, vm),
                Divider(),
                buildLogOutWidget(context, vm),
              ],
            );
          },
        ),
      ),
    );
  }

  buildEditProfileWidget(BuildContext context, SettingsViewModel vm) {
    return GestureDetector(
      onTap: () {
        ScreenUtils.openScreen(context, AppRouter.editProfile);
      },
      child: Container(
        margin: UiHelper.horizontalEdge16,
        height: Dimens.size48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ic_setting_edit_profile,
              color: AppColors.settingIconColor,
            ),
            UiHelper.horizontalBox8,
            Expanded(
                child: Text(
              AppLocalizations.of(context)!.translate('edit_profile'),
              style: textStyleNormalTitle,
            )),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textColor,
            ),
          ],
        ),
      ),
    );
  }

  buildChangePasswordWidget(BuildContext context, SettingsViewModel vm) {
    return GestureDetector(
      onTap: () => ScreenUtils.openScreen(context, AppRouter.changePassword),
      child: Container(
        margin: UiHelper.horizontalEdge16,
        height: Dimens.size48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ic_lock,
              color: AppColors.settingIconColor,
            ),
            UiHelper.horizontalBox8,
            Expanded(
                child: Text(
              AppLocalizations.of(context)!.translate('change_password'),
              style: textStyleNormalTitle,
            )),
            Icon(Icons.arrow_forward_ios, color: AppColors.textColor),
          ],
        ),
      ),
    );
  }

  buildSettingBiometricWidget(BuildContext context, SettingsViewModel vm) {
    return Container(
      margin: UiHelper.horizontalEdge16,
      height: Dimens.size48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ic_fingerprint,
            color: AppColors.settingIconColor,
          ),
          UiHelper.horizontalBox8,
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.translate('setting_biometric'),
                style: textStyleNormalTitle,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  AppLocalizations.of(context)!
                      .translate('use_biometric_instead_of_password_to_login'),
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: Dimens.size10,
                      fontWeight: FontWeight.normal,
                      color: AppColors.textColor),
                ),
              ),
            ],
          )),
          Transform.scale(
            transformHitTests: false,
            scale: 0.8,
            child: CupertinoSwitch(
              activeColor: AppColors.settingIconColor,
              value: vm.enableBiometric,
              onChanged: (bool value) {
                vm.activeLoginBiometric(value);
              },
            ),
          )
        ],
      ),
    );
  }

  buildLogOutWidget(BuildContext context, SettingsViewModel vm) {
    return GestureDetector(
      onTap: () {
        showAlertDialog(
            content: AppLocalizations.of(context)!.translate('confirm_logout'),
            context: context,
            onPressed: () => vm.logOutClient(context),
            defaultActionText: AppLocalizations.of(context)!.translate('yes'),
            cancelActionText:
                AppLocalizations.of(context)!.translate('cancel'));
      },
      child: Container(
        margin: UiHelper.horizontalEdge16,
        height: Dimens.size48,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ic_logout,
              color: AppColors.settingIconColor,
            ),
            UiHelper.horizontalBox8,
            Expanded(
                child: Text(
              AppLocalizations.of(context)!.translate('log_out'),
              style: textStyleNormalTitle,
            )),
          ],
        ),
      ),
    );
  }
}
