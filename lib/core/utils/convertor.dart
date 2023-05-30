import 'dart:ui';

import 'package:intl/intl.dart';

class Convertors {
  static double? convertDynamicToDouble(dynamic d) {
    if (d is double) return d;
    if (d is int) return d.toDouble();
    if (d is String) return double.parse(d);
    return null;
  }

  static String? compareBookingFeeV2(
      double? estimatedPrice, double? seagolfPrice) {
    if (seagolfPrice != null && seagolfPrice != 0) {
      return formatPrice(seagolfPrice);
    }
    if (estimatedPrice != null) {
      return formatPrice(estimatedPrice);
    }
    return "";
  }

  static String? compareBookingFee(
      double? publicPrice, double? promotionPrice) {
    if (publicPrice != null && promotionPrice == null || promotionPrice == 0) {
      return formatPrice(publicPrice);
    }
    if (publicPrice == null && promotionPrice != null) {
      return formatPrice(promotionPrice);
    }
    if (publicPrice != null &&
        promotionPrice != null &&
        publicPrice > promotionPrice) {
      return formatPrice(promotionPrice);
    }
    if (publicPrice != null &&
        promotionPrice != null &&
        publicPrice < promotionPrice) {
      return formatPrice(publicPrice);
    }
    if (publicPrice != null &&
        promotionPrice != null &&
        publicPrice == promotionPrice) {
      return formatPrice(publicPrice);
    }
    return "";
  }

  static String? formatPrice(double? input) {
    if (input == null) return null;
    return '${NumberFormat("#,##0", "en_US").format(input)}'.trim();
  }

  static String? convertMoneyFormat(double? input) {
    if (input == null) return null;
    return NumberFormat.currency(locale: 'vi', decimalDigits: 0, symbol: 'VND')
        .format(input);
  }

  static String? convertMoneyWithoutSymbol(double? input) {
    if (input == null) return null;
    return '${NumberFormat.currency(locale: 'vi', decimalDigits: 0, symbol: '').format(input)}'
        .trim();
  }

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
