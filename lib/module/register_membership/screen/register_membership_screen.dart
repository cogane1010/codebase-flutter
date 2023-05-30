import 'package:brg_management/common/widget/base_background.dart';
import 'package:brg_management/common/widget/base_text_field.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/resources/asset_image.dart';
import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/core/utils/screen_util.dart';
import 'package:brg_management/core/utils/theme_util.dart';
import 'package:brg_management/module/register_membership/view_model/register_membership_vm.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterMemberShipScreen extends StatefulWidget {
  const RegisterMemberShipScreen({Key? key}) : super(key: key);

  @override
  _RegisterMemberShipScreenState createState() =>
      _RegisterMemberShipScreenState();
}

class _RegisterMemberShipScreenState extends State<RegisterMemberShipScreen> {
  var viewModel;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      viewModel =
          Provider.of<RegisterMemberShipViewModel>(context, listen: false);
      viewModel.initData();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
            onTap: () => ScreenUtils.closeScreen(context),
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),
          title: Text(
              AppLocalizations.of(context)!.translate("register_memberShip")),
          actions: [
            GestureDetector(
                child: Container(
                    margin: UiHelper.horizontalEdge24,
                    child: SvgPicture.asset(
                      ic_support,
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    )))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg_tmp),
              fit: BoxFit.cover,
            ),
          ),
          child: Consumer<RegisterMemberShipViewModel>(
            builder: (context, vm, child) {
              return Stack(children: [
                Container(
                  margin: UiHelper.edgeInsetAll24,
                  child: Form(
                    key: vm.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          UiHelper.verticalBox4,
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
                            controller: vm.fullNameController,
                            maxLength: 100,
                            style: textStyleTinyContent,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              contentPadding: EdgeInsets.only(
                                  left: Dimens.size8,
                                  right: Dimens.size8,
                                  bottom: Dimens.size2),
                            ),
                            validator: (value) => vm.validateFullName(),
                          ),
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
                            controller: vm.phoneController,
                            maxLength: 14,
                            style: textStyleTinyContent,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              contentPadding: EdgeInsets.only(
                                  left: Dimens.size8,
                                  right: Dimens.size8,
                                  bottom: Dimens.size2),
                            ),
                            validator: (value) => vm.validatePhone(),
                          ),
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
                            controller: vm.emailController,
                            maxLength: 255,
                            style: textStyleTinyContent,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              contentPadding: EdgeInsets.only(
                                  left: Dimens.size8,
                                  right: Dimens.size8,
                                  bottom: Dimens.size2),
                            ),
                            validator: (value) => vm.validateEmailValue(),
                          ),
                          UiHelper.verticalBox16,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate("golf_course"),
                              style: textStyleNormalTitle,
                            ),
                          ),
                          UiHelper.verticalBox8,
                          UiHelper.verticalBox16,
                        ],
                      ),
                    ),
                  ),
                ),
                buildConfirmWidget(context, vm)
              ]);
            },
          ),
        ),
      ),
    );
  }

  buildConfirmWidget(BuildContext context, RegisterMemberShipViewModel vm) {
    return GestureDetector(
      onTap: () {
        vm.registerMemberShip(context);
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(
            left: Dimens.size16, right: Dimens.size16, bottom: Dimens.size10),
        child: BaseBackground(
          topLeftRadius: Radius.circular(Dimens.size12),
          bottomRightRadius: Radius.circular(Dimens.size12),
          height: Dimens.size45,
          borderColor: AppColors.settingIconColor,
          backgroundColor: AppColors.settingIconColor,
          child: Text(
            AppLocalizations.of(context)!.translate('confirm').toUpperCase(),
            // "Đặt thêm lịch chơi khác".toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: textStyleWhiteSmallContent,
          ),
        ),
      ),
    );
  }
}
