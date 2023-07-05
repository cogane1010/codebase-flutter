import 'package:brg_management/common/widget/base_background.dart';
import 'package:brg_management/common/widget/base_button.dart';
import 'package:brg_management/common/widget/base_text_field.dart';
import 'package:brg_management/common/widget/hot_line.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/module/authen/login/view_model/login_view_model.dart';
import 'package:brg_management/resources/asset_image.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../../../splash/view_model/splash_vm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication localAuthentication = LocalAuthentication();
  late LoginViewModel authViewModel;
  final formKey = GlobalKey<FormState>();
  late SplashViewModel splashViewModel;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      splashViewModel = Provider.of<SplashViewModel>(context, listen: false);
      authViewModel = Provider.of<LoginViewModel>(context, listen: false);

      splashViewModel.initData();
      authViewModel.initViewModel();
      authViewModel.checkAvailableBiometric();
    });

    super.initState();
  }

  String _setImage() {
    String _flag;
    final Locale currentLocale = Localizations.localeOf(context);
    if (currentLocale.languageCode == 'en') {
      _flag = ic_en_lang;
    } else {
      _flag = ic_vn_lang;
    }
    return _flag;
  }

  bool _keyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      body: Consumer<LoginViewModel>(
        builder: (context, vm, child) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(bg_login),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: Dimens.size24,
                              bottom: Dimens.size26,
                              top: Dimens.size40),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  vm.changeLanguage(context);
                                },
                                child: Image.asset(
                                  _setImage(),
                                  height: Dimens.size36,
                                  width: Dimens.size36,
                                ),
                              )),
                        ),
                        Center(
                          child: Text(
                              AppLocalizations.of(context)!
                                  .translate('app_name_title'),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textRedColor),
                              textAlign: TextAlign.center),
                        ),
                        UiHelper.verticalBox160,
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.size24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UiHelper.verticalBox4,
                              BaseTextField(
                                style: TextStyle(
                                    fontSize: Dimens.size14,
                                    color: AppColors.textColor),
                                // setImageNotBackground: bg_text_input,
                                backgroundImageAsset: bg_text_input_login,
                                controller: vm.emailController,
                                hintText: AppLocalizations.of(context)!
                                    .translate('user_name'),
                                prefixIconPath: ic_account_png,
                                borderColor: AppColors.black,
                                hintColor: AppColors.black,
                                textColor: AppColors.textColor,
                                iconLeftColor: AppColors.black,
                                onSaved: (value) {
                                  vm.emailController.text = value!;
                                },
                                validator: (value) =>
                                    vm.validateUserName(value!, context),
                              ),
                              UiHelper.verticalBox32,
                              BaseTextField(
                                style: TextStyle(
                                    fontSize: Dimens.size14,
                                    color: AppColors.textColor),
                                // setImageNotBackground: bg_text_input,
                                backgroundImageAsset: bg_text_input_login,
                                controller: vm.passwordController,
                                hintColor: AppColors.black,
                                hintText: AppLocalizations.of(context)!
                                    .translate('password'),
                                prefixIconPath: ic_lock_png,
                                borderColor: AppColors.black,
                                textColor: AppColors.textColor,
                                obscureText: vm.isHidePassword,
                                iconLeftColor: AppColors.black,
                                onSaved: (value) {
                                  vm.passwordController.text = value!;
                                },
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    vm.setIsHidePassWord(!vm.isHidePassword);
                                  },
                                  icon: Image.asset(
                                    vm.isHidePassword
                                        ? 'assets/png/hide_pw_icon.png'
                                        : 'assets/png/visibility_black_24dp.png',
                                    width: Dimens.size22,
                                    height: Dimens.size22,
                                    color: AppColors.black,
                                  ),
                                ),
                                validator: (value) =>
                                    vm.validatePW(value!, context),
                              ),
                              Container(
                                height: Dimens.size40,
                                child: Row(
                                  children: [
                                    // TextButton(
                                    //     onPressed: () {
                                    //       forgetPasswordDialog(context);
                                    //     },
                                    //     child: Text(
                                    //       AppLocalizations.of(context)!
                                    //           .translate('forget_password'),
                                    //       style: TextStyle(
                                    //           color: Colors.white,
                                    //           fontSize: Dimens.size12),
                                    //     )),
                                    Spacer(),
                                    Transform.translate(
                                      offset: const Offset(Dimens.size10, 0),
                                      child: Checkbox(
                                        fillColor: MaterialStateProperty.all(
                                            vm.isFocusSaveUserInfo
                                                ? Colors.black
                                                : Colors.transparent),
                                        checkColor: Colors.red,
                                        shape: CircleBorder(),
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                          (states) => BorderSide(
                                              width: Dimens.size1,
                                              color: Colors.black),
                                        ),
                                        value: vm.isFocusSaveUserInfo,
                                        onChanged: (value) {
                                          vm.setSaveUserInfo(value!);
                                        },
                                      ),
                                    ),
                                    Text(
                                      vm.isFocusSaveUserInfo
                                          ? AppLocalizations.of(context)!
                                              .translate('saved_user')
                                          : AppLocalizations.of(context)!
                                              .translate('remember_me'),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: Dimens.size16,
                                          fontFamily: 'Montserrat'),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: BaseButton(
                                      style: TextStyle(
                                          fontSize: Dimens.size18,
                                          color: AppColors.whiteColor),
                                      textColor: AppColors.whiteColor,
                                      color: AppColors.whiteColor,
                                      assetImage: bg_red_button,
                                      height: Dimens.size40,
                                      text: AppLocalizations.of(context)!
                                          .translate('login'),
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          vm.submitLogin(
                                              context,
                                              vm.emailController.text,
                                              vm.passwordController.text);
                                        }
                                      },
                                    ),
                                  ),
                                  //UiHelper.horizontalBox12,
                                  // GestureDetector(
                                  //   onTap: () async {
                                  //     vm.checkIsActiveBiometric(
                                  //         context, vm.emailController.text);
                                  //   },
                                  //   child: BaseBackground(
                                  //     elevation: 10,
                                  //     backgroundImageUrl: bg_button_biometric,
                                  //     child: Container(
                                  //       width: Dimens.size40,
                                  //       height: Dimens.size40,
                                  //       padding: EdgeInsets.all(Dimens.size12),
                                  //       child: !vm.faceIDBiometric
                                  //           ? Image.asset(
                                  //               ic_biometric,
                                  //               color: AppColors.appBarColor,
                                  //             )
                                  //           : Image.asset(
                                  //               ic_face_id,
                                  //               color: AppColors.appBarColor,
                                  //             ),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                              UiHelper.verticalBox32,
                              // Center(
                              //   child: RichText(
                              //     text: TextSpan(
                              //       text: AppLocalizations.of(context)!
                              //           .translate('done_have_account'),
                              //       style: TextStyle(
                              //           fontSize: Dimens.size12,
                              //           fontFamily: 'Montserrat'),
                              //       children: <TextSpan>[
                              //         TextSpan(
                              //           text: " " +
                              //               AppLocalizations.of(context)!
                              //                   .translate('sign_up_2'),
                              //           recognizer: new TapGestureRecognizer()
                              //             ..onTap = () =>
                              //                 ScreenUtils.openScreen(
                              //                     context, AppRouter.signIn),
                              //           style: TextStyle(
                              //               color: Colors.orange,
                              //               fontFamily: 'Montserrat'),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: !_keyboardVisible,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: HotLineView()))
              ],
            ),
          );
        },
      ),
    );
  }

  Future<bool> forgetPasswordDialog(BuildContext context) async {
    TextEditingController userNameController = TextEditingController();
    bool isResult = false;
    LoginViewModel authViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      barrierDismissible:
          true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.clear,
                    size: Dimens.size26,
                    color: Colors.white,
                  ),
                ),
                BaseBackground(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .translate('reset_password'),
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: Dimens.size18,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('message_reset_password'),
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: Dimens.size12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimens.size12,
                            right: Dimens.size12,
                            top: Dimens.size16,
                            bottom: Dimens.size16),
                        child: BaseTextField(
                          controller: userNameController,
                          borderColor: AppColors.grayLineOpacity,
                          height: Dimens.size45,
                          errorStyle: TextStyle(color: Colors.red),
                          style: TextStyle(
                              fontSize: Dimens.size12,
                              color: AppColors.textColor),
                          hintText: AppLocalizations.of(context)!
                              .translate('email_or_phone_number'),
                          hintColor: Colors.black,
                          validator: (value) =>
                              authViewModel.validateUserName(value!, context),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: Dimens.size4,
                            right: Dimens.size4,
                            bottom: Dimens.size6),
                        child: BaseButton(
                          elevation: 50,
                          height: Dimens.size60,
                          textPadding: EdgeInsets.only(bottom: Dimens.size6),
                          style: TextStyle(
                              fontSize: Dimens.size14,
                              color: AppColors.whiteColor),
                          color: AppColors.whiteColor,
                          assetImage: bg_button_app,
                          lineColor: AppColors.whiteColor,
                          text: AppLocalizations.of(context)!
                                      .locale
                                      .languageCode
                                      .toString() ==
                                  'en'
                              ? AppLocalizations.of(context)!
                                  .translate('confirm')
                                  .toUpperCase()
                              : AppLocalizations.of(context)!
                                  .translate('confirm')
                                  .toUpperCase(),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              authViewModel.forgetPassword(
                                  context, userNameController.text);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      if (!isEmpty(value)) {
        isResult = true;
      }
    });
    return isResult;
  }
}
