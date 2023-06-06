import 'dart:io';

import 'package:brg_management/common/dialog/dialog_utils.dart';
import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/data/model/base_response_api.dart';
import 'package:brg_management/data/model/data_login.dart';
import 'package:brg_management/data/repositories/forget_password_api.dart';
import 'package:brg_management/data/repositories/login_api.dart';
import 'package:brg_management/data/repositories/splash_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

import '../../../../common/dialog/popup_notif.dart';
import '../../../../configs/app_localizations.dart';
import '../../../../configs/base_api.dart';
import '../../../../configs/router.dart';
import '../../../../core/shared_preferences/shared_preferences.dart';
import '../../../../core/utils/screen_util.dart';
import '../../../../data/local/user_session.dart';
import '../../../../data/model/response.dart';
import '../../../../main.dart';

// vlol
class LoginViewModel extends ChangeNotifier {
  final forgetPasswordApi = ForgetPassWord();

  // editing controller
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String? errorMessage;
  bool isHidePassword = true;
  LoginApi authApi = LoginApi();
  BaseResponseApi? dataLogin;
  SharedPreferences sharedPreferences = SharedPreferences.instance;
  bool isFocusSaveUserInfo = false;
  bool isShowLoading = false;
  bool isRequestNewPassword = false;
  bool faceIDBiometric = false;
  final storage = new FlutterSecureStorage();
  SplashApi api = SplashApi();

  void initViewModel() async {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    emailController.text = "admin";
    passwordController.text = "Brg123456";
    isShowLoading = false;
    faceIDBiometric = false;
    isRequestNewPassword = false;
    checkLateLogin();
  }

  void submitLogin(BuildContext context, String username, String pw) async {
    doLogin(context, username, pw);
  }

  void autoLogin(BuildContext context) async {
    String? username = await storage.read(key: 'usn');
    String? pw = await storage.read(key: 'pw');
    doLogin(context, username!, pw!);
  }

  void doLogin(BuildContext context, String username, String pw,
      {String? otpid, String? otpcode}) async {
    isShowLoading = true;

    notifyListeners();
    try {
      ApiResponse json =
          await authApi.onLogin(username, pw, otpid: otpid, otpcode: otpcode);
      if (json.success && json.responseObject['Data'] != null) {
        String usernameCache = await storage.read(key: 'usn') ?? '';
        if (username != usernameCache)
          sharedPreferences.remove("active_biometric" + usernameCache);
        print("doLogin ${json.responseObject['Data']}");
        // var aaa = json.responseObject['Data'];
        // var bbb = DataLogin.fromJson(json.responseObject['Data']);
        dataLogin = BaseResponseApi<DataLogin>.fromJson(json.responseObject,
            compileData: (data) => !isEmpty(json.responseObject['Data'])
                ? DataLogin.fromJson(json.responseObject['Data'])
                : DataLogin());
        print("doLogin11 ${dataLogin!.isSuccess}");

        if (!isEmpty(dataLogin) && dataLogin!.isSuccess!) {
          DataLogin data = dataLogin!.data;
          UserSession.instance.token = data.token!;
          UserSession.instance.usn = username;
          UserSession.instance.pw = pw;

          if (!isEmpty(data.userInfo)) {
            UserSession.instance.fullName = data.userInfo!.fullName.toString();
            UserSession.instance.orgName = data.userInfo!.orgName.toString();
            UserSession.instance.email = data.userInfo!.email.toString();
            UserSession.instance.userName = data.userInfo!.userName.toString();
          }

          storage.write(key: "usn", value: '');
          storage.write(key: 'pw', value: '');

          if (isFocusSaveUserInfo) {
            // sharedPreferences.setUsername(username);
            storage.write(key: "usn", value: username);
            storage.write(key: 'pw', value: pw);
            // sharedPreferences.setPw(pw);

          } else {
            sharedPreferences.remove("pw");
            sharedPreferences.remove("usn");
          }
          ScreenUtils.openScreenAndRemoveUtil(context, AppRouter.dashboard);
          // if (json.responseObject['data']['isForgotPass'] ?? false) {
          //   ScreenUtils.openScreenAndRemoveUtil(context, AppRouter.dashboard, arguments: pw);
          //   isRequestNewPassword = false;
          // } else
          //   ScreenUtils.openScreenAndRemoveUtil(context, AppRouter.dashboard);
          //   String? firebaseToken = await Messaging.getFirebaseToken();
          //   saveSettings(firebaseToken ?? '', Localizations.localeOf(context).languageCode);
        } else {
          showAlertDialog(
              content: dataLogin!.errorMessage.toString(),
              context: context,
              defaultActionText: "Đóng");
        }
      } else {
        showAlertDialog(
            content: json.responseObject['errorMessage'],
            context: context,
            defaultActionText:
                AppLocalizations.of(context)!.translate('close'));
      }
    } catch (e) {
      print('error caught: $e');
      showAlertDialog(
          content: BaseApi.convertMsgCodeToMessage('system_error'),
          context: context,
          defaultActionText: AppLocalizations.of(context)!.translate('close'));
    }

    isShowLoading = false;
    notifyListeners();
  }

  String? validateUserName(String value, BuildContext context) {
    if (value.isEmpty) {
      return AppLocalizations.of(context)!
          .translate('require_enter_username_message');
    }
    if (value.length < 3) {
      return AppLocalizations.of(context)!.translate('email_format_error');
    }
    // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
    //     .hasMatch(value)) {
    //   return AppLocalizations.of(context)!.translate('email_format_error');
    // }
    return null;
  }

  String? validatePW(String value, BuildContext context) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value.isEmpty) {
      return AppLocalizations.of(context)!
          .translate('require_enter_password_message');
    }
    if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context)!.translate('pw_pattern_not_match');
    }
    return null;
  }

  setSaveUserInfo(bool isValue) {
    isFocusSaveUserInfo = isValue;
    notifyListeners();
  }

  setIsHidePassWord(bool isValue) {
    isHidePassword = isValue;
    notifyListeners();
  }

  void checkLateLogin() async {
    // String? username = await sharedPreferences.username;
    // String? pw = await sharedPreferences.pw;
    String? username = await storage.read(key: 'usn');
    String? pw = await storage.read(key: 'pw');
    if (!isEmpty(username) && !isEmpty(pw)) {
      isFocusSaveUserInfo = true;
      emailController.text = username!;
    } else {
      isFocusSaveUserInfo = false;
    }
    notifyListeners();
  }

  void checkAvailableBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();

    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.face)) {
        // Face ID.
        faceIDBiometric = true;
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        // Touch ID.
        faceIDBiometric = false;
      }
    } else {
      faceIDBiometric = false;
    }
    notifyListeners();
  }

  void checkIsActiveBiometric(BuildContext context, String name) async {
    bool isActive = await sharedPreferences.getActiveBiometric(name);
    // String? username = await sharedPreferences.username;
    // String? pw = await sharedPreferences.pw;
    String? username = await storage.read(key: 'usn');
    String? pw = await storage.read(key: 'pw');

    if (isActive && !isEmpty(username) && !isEmpty(pw)) {
      bool isAuthenticated = await authenticateWithBiometrics(context);
      if (isAuthenticated && username == emailController.text) {
        autoLogin(context);
      } else {
        // if (Platform.isIOS) {
        //   showAlertDialog(
        //       content: AppLocalizations.of(context)!.translate('error_verify_biometric'),
        //       context: context,
        //       defaultActionText: AppLocalizations.of(context)!.translate('close'));
        // }
      }
    } else {
      showNotification(context,
          AppLocalizations.of(context)!.translate('not_active_biometric'));

      // showAlertDialog(
      //     content: AppLocalizations.of(context)!.translate('not_active_biometric'),
      //     context: context,
      //     defaultActionText: AppLocalizations.of(context)!.translate('close'));
    }
  }

  Future<bool> authenticateWithBiometrics(BuildContext context) async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;
    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await localAuthentication.authenticate(
            localizedReason: 'Please complete the biometrics to proceed.',
            useErrorDialogs: false,
            biometricOnly: true,
            stickyAuth: true,
            iOSAuthStrings: IOSAuthMessages(
              localizedFallbackTitle: null,
            ));
      } on PlatformException catch (e) {
        if (e.code.contains(auth_error.lockedOut)) {
          // Handle this exception here.
          showAlertDialog(
              content:
                  AppLocalizations.of(context)!.translate('lock_biometric'),
              context: context,
              defaultActionText:
                  AppLocalizations.of(context)!.translate('close'));
        }
      }
    } else {
      showAlertDialog(
          content:
              AppLocalizations.of(context)!.translate('error_verify_biometric'),
          context: context,
          defaultActionText: AppLocalizations.of(context)!.translate('close'));
    }
    return isAuthenticated;
  }

  void forgetPassword(BuildContext context, String username) async {
    try {
      ApiResponse json = await forgetPasswordApi.forgetPassWord(username);
      isRequestNewPassword = json.success && json.responseObject['isSuccess'];
      if (json.success) {
        if (json.responseObject['isSuccess']) {
          Navigator.pop(context, true);
          showAlertDialog(
              content: AppLocalizations.of(context)!
                  .translate("request_new_password_success"),
              context: context,
              defaultActionText:
                  AppLocalizations.of(context)!.translate('close'));
        } else if (json.responseObject["msgParams"] == null) {
          showAlertDialog(
              content: BaseApi.convertMsgCodeToMessage(
                  json.responseObject["msgCode"]),
              context: context,
              defaultActionText:
                  AppLocalizations.of(context)!.translate('close'));
        } else {
          String minutes = AppLocalizations.of(context)!.translate("minutes");
          showAlertDialog(
              content: BaseApi.convertMsgCodeToMessage(
                      json.responseObject["msgCode"])
                  .toString()
                  .replaceAll(
                      "{0}", "${json.responseObject["msgParams"][0]} $minutes"),
              context: context,
              defaultActionText:
                  AppLocalizations.of(context)!.translate('close'));
        }
      } else {
        showAlertDialog(
            content:
                BaseApi.convertMsgCodeToMessage(json.responseObject["msgCode"]),
            context: context,
            defaultActionText:
                AppLocalizations.of(context)!.translate('close'));
      }
    } catch (e) {
      showAlertDialog(
          content: BaseApi.convertMsgCodeToMessage('system_error'),
          context: context,
          defaultActionText: AppLocalizations.of(context)!.translate('close'));
    }
  }

  // Navigator.push(
  // context,
  // MaterialPageRoute(
  // builder: (context) => OtpScreen(
  // callbackVerifyOtpSuccess: (value) {
  // if (value == true) {
  // ScreenUtils.closeScreen(context);
  // ScreenUtils.openScreenAndRemoveUtil(
  // context, AppRouter.login);
  // }
  // },
  // featureName: Constants.CREATE_ACCOUNT,
  // phoneNumber: phoneController.text,
  // email: emailController.text,
  // accountInfo: accountInfo,
  // )));
  void changeLanguage(BuildContext context) {
    SharedPreferences sharedPreferences = SharedPreferences.instance;
    final Locale currentLocale = Localizations.localeOf(context);
    if (currentLocale.languageCode == 'en') {
      Locale viLocale = Locale('vi', 'VN');
      sharedPreferences.setLanguage('vi');
      MyApp.setLocale(context, viLocale);
      UserSession.instance.currentLanguage = "vi";
    } else {
      Locale usLocale = Locale('en', 'US');
      sharedPreferences.setLanguage('en');
      MyApp.setLocale(context, usLocale);
      UserSession.instance.currentLanguage = "en";
    }
  }

  Future saveSettings(String fcmToken, String lang) async {
    ApiResponse json = await authApi.saveSettings(fcmToken, lang);
    debugPrint('save Settings');
  }
}
