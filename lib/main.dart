import 'dart:io';

import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/utils/locale_util.dart';
import 'package:brg_management/module/authen/login/screen/login_screen.dart';
import 'package:brg_management/resources/enums.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'configs/app_config.dart';
import 'configs/messaging.dart';
import 'configs/provider.dart';
import 'configs/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  AppRouter.configRouter();
  await AppConfig.instance.loadConfig(env: Environment.stg);
  final locale = await checkLocale();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _osVersion = '';
  String _deviceId = '', _deviceName = '';

  try {
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      _osVersion = iosDeviceInfo.systemVersion;
      _deviceId = iosDeviceInfo.identifierForVendor;
      _deviceName = iosDeviceInfo.model;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      _osVersion = androidDeviceInfo.version.release;
      _deviceId = androidDeviceInfo.androidId;
      _deviceName = androidDeviceInfo.model;
    }
  } catch (ex) {
    debugPrint('-- Exception: ${ex.toString()}');
  }
  runApp(MyApp(
    locale: locale,
  ));
}

class MyApp extends StatefulWidget {
  Locale? locale;

  MyApp({this.locale});

  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeLanguage(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  changeLanguage(Locale locale) {
    setState(() {
      widget.locale = locale;
    });
  }

  @override
  void initState() {
    EasyLoading.instance.userInteractions = false;
    Future.delayed(const Duration(milliseconds: 5000), () async {
      //   // init firebase message here
      //   await Messaging.initFirebaseMessaging();
      //   await Messaging.getFirebaseToken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: AppProvider.getAll(),
      child: GetMaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        builder: EasyLoading.init(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        locale: widget.locale,
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == widget.locale!.languageCode &&
                supportedLocale.countryCode == widget.locale!.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        supportedLocales: const [
          Locale('vi', 'VN'),
          Locale('en', 'US'),
        ],
        routes: AppRouter.appRouter,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: ("Montserrat"),
          primarySwatch: Colors.blue,
        ),
        home: RootView(title: 'BRG Work Manager'),
      ),
    );
  }
}

class RootView extends StatefulWidget {
  RootView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      checkSafeDevice().then((value) {
        if (value) {
          return Fluttertoast.showToast(
              msg: AppLocalizations.of(
                      NavigationService.navigatorKey.currentContext!)!
                  .translate('cant_runt_on_root_device'));
        }
      });
    });

    return LoginScreen();
  }

  Future<bool> checkSafeDevice() async {
    return await FlutterJailbreakDetection.jailbroken;
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
