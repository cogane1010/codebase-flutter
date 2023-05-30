import 'dart:convert';
import 'dart:ui';

import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static String apiFormat = "yyyy-MM-dd'T'HH:mm:ss";
  static String apiFormatTZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

  static String apiFormatTeeTime = "yyyy-MM-dd'T'HH:mm:ss";

  static String timeFormat = "HH:mm";

  static String? convertToString(DateTime? date,
      {String format = 'dd/MM/yyyy'}) {
    if (date == null) return null;
    final formatter = DateFormat(format);
    final formatted = formatter.format(date);
    return formatted;
  }

  static DateTime? convertToDateTime(String? data,
      {String format = 'dd/MM/yyyy'}) {
    if (isEmpty(data)) return null;
    final formatter = DateFormat(format);
    final parseDate = formatter.parse(data!);
    return parseDate;
  }

  static String dateFormatter(DateTime? date) {
    if (date == null) {
      return "";
    }
    dynamic dayData;
    final Locale currentLocale =
        Localizations.localeOf(NavigationService.navigatorKey.currentContext!);
    if (currentLocale.languageCode == 'en') {
      dayData =
          '{ "1" : "Monday", "2" : "Tuesday", "3" : "Wednesday", "4" : "Thursday", "5" : "Friday", "6" : "Saturday", "7" : "Sunday" }';
    } else {
      dayData =
          '{ "1" : "Thứ Hai", "2" : "Thứ Ba", "3" : "Thứ Tư", "4" : "Thứ Năm", "5" : "Thứ Sáu", "6" : "Thứ Bảy", "7" : "Chủ Nhật" }';
    }
    return "(" +
        json.decode(dayData)['${date.weekday}'] +
        ")" +
        " " +
        date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }
}

String dateTimeFormatter(String? dateTime, {String? format}) {
  if (dateTime == null || dateTime.isEmpty) return "";
  return DateFormat(format ?? 'yyyy/MM/dd')
      .format(DateTime.parse(dateTime).toLocal())
      .toString();
}
