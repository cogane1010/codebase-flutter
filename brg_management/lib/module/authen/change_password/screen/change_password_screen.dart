import 'package:brg_management/common/dialog/dialog_utils.dart';
import 'package:brg_management/common/dialog/popup_notif.dart';
import 'package:brg_management/common/widget/base_background.dart';
import 'package:brg_management/common/widget/base_text_field.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/configs/router.dart';
import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/resources/asset_image.dart';
import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/core/utils/screen_util.dart';
import 'package:brg_management/core/utils/theme_util.dart';
import 'package:brg_management/module/authen/change_password/view_model/change_password_vm.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late ChangePasswordViewModel viewModel;
  var oldPw;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      viewModel = Provider.of<ChangePasswordViewModel>(context, listen: false);
      viewModel.initListener();
      oldPw = ModalRoute.of(context)!.settings.arguments;
      if (!isEmpty(oldPw)) viewModel.enterOldPasswordController.text = oldPw!;
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
          title: Text(
              AppLocalizations.of(context)!.translate('title_change_password')),
          leading: GestureDetector(
              onTap: () {
                viewModel.clear();
                ScreenUtils.closeScreen(context);
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bg_tmp),
              fit: BoxFit.cover,
            ),
          ),
          padding: UiHelper.edgeInsetAll24,
          child: Consumer<ChangePasswordViewModel>(
            builder: (context, vm, child) => Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isEmpty(oldPw)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UiHelper.verticalBox4,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate('enter_old_password'),
                                style: textStyleNormalTitle,
                              ),
                            ),
                            UiHelper.verticalBox8,
                            BaseTextField(
                              maxLength: 30,
                              obscureText: true,
                              controller: vm.enterOldPasswordController,
                              obscuringCharacter: '●',
                              style: textStyleChangePassWord,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                contentPadding: UiHelper.horizontalEdge8,
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                  UiHelper.verticalBox16,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('enter_new_password'),
                      style: textStyleNormalTitle,
                    ),
                  ),
                  UiHelper.verticalBox8,
                  BaseTextField(
                    textAlignVertical: TextAlignVertical.center,
                    maxLength: 30,
                    obscureText: !vm.enterNewPasswordObscure,
                    obscuringCharacter: '●',
                    controller: vm.enterNewPasswordController,
                    style: textStyleChangePassWord,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      counterText: "",
                      contentPadding: UiHelper.horizontalEdge8,
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Image.asset(
                            vm.enterNewPasswordObscure
                                ? 'assets/png/visibility_black_24dp.png'
                                : 'assets/png/hide_pw_icon.png',
                            width: 22,
                            height: 22,
                            color: Colors.grey),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          vm.updateEnterNewPasswordObscure();
                        },
                      ),
                    ),
                  ),
                  UiHelper.verticalBox16,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate('retype_new_password'),
                      style: textStyleNormalTitle,
                    ),
                  ),
                  UiHelper.verticalBox8,
                  BaseTextField(
                    textAlignVertical: TextAlignVertical.center,
                    maxLength: 30,
                    style: textStyleChangePassWord,
                    obscureText: !vm.retypeNewPasswordObscure,
                    obscuringCharacter: '●',
                    //This will obscure text dynamically
                    controller: vm.retypeNewPasswordController,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      counterText: "",
                      contentPadding: UiHelper.horizontalEdge8,
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Image.asset(
                          vm.retypeNewPasswordObscure
                              ? 'assets/png/visibility_black_24dp.png'
                              : 'assets/png/hide_pw_icon.png',
                          width: 22,
                          height: 22,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          vm.updateRetypeNewPasswordObscure();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              buildConfirmWidget(context, vm)
            ]),
          ),
        ),
      ),
    );
  }

  buildConfirmWidget(BuildContext context, ChangePasswordViewModel vm) {
    return GestureDetector(
      onTap: () async {
        if (!vm.confirmable) return;
        String? message = await vm.validateInput();
        if (message == null) {
          if (isEmpty(oldPw)) {
            /// chiến xử lý với luồng thay đổi mật khẩu đi từ màn hình setting
            var response = await vm.changePassword();
            if (response.isSuccess ?? false) {
              showSuccessDialog(context,
                  message: AppLocalizations.of(context)!
                      .translate("change_the_password_to_public"),
                  onDismiss: () {
                ScreenUtils.openScreenAndRemoveUtil(context, AppRouter.login);
              });
            } else {
              showAlertDialog(
                  content: response.message ??
                      AppLocalizations.of(context)!.translate("system_error"),
                  context: context,
                  defaultActionText:
                      AppLocalizations.of(context)!.translate('close'));
            }
            return;
          } else {
            /// đường xử lý thay mật khẩu từ luồng quên mật khẩu
            vm.changePasswordNew(oldPw: oldPw).then((dataCallback) => {
                  if (!isEmpty(dataCallback))
                    {
                      showSuccessDialog(context,
                          message: dataCallback!.errorMessage, onDismiss: () {
                        Navigator.pop(context);
                      })
                    }
                });
          }
        }
        Fluttertoast.showToast(msg: message!);
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        child: BaseBackground(
          topLeftRadius: Radius.circular(Dimens.size12),
          bottomRightRadius: Radius.circular(Dimens.size12),
          height: Dimens.size45,
          borderColor:
              vm.confirmable ? AppColors.settingIconColor : Colors.grey,
          backgroundColor:
              vm.confirmable ? AppColors.settingIconColor : Colors.grey,
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
