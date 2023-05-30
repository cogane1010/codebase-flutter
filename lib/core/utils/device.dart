import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class CurrentDevice {
  static double getWithSize(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return size.width;
  }

  static double getHeightSize(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return size.height;
  }

  static Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      //Xiaomi Redmi Note 7
      return '${androidInfo.manufacturer} ${androidInfo.model}';
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      //iPhone 11 Pro Max iPhone
      return '${iosInfo.name} ${iosInfo.model}';
    }
    return '';
  }

  static Future<String> getOSName() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      // Android 9 (SDK 28)
      return 'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})';
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      // iOS 13.1, iPhone 11 Pro Max iPhone
      return '${iosInfo.systemName}, ${iosInfo.systemVersion}';
    }
    return '';
  }

  static String getDevice() {
    if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    }
    return 'others';
  }
}
