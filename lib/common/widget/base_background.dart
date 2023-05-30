import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';

class BaseBackground extends StatelessWidget {
  const BaseBackground(
      {Key? key,
      required this.child,
      this.width,
      this.height,
      this.borderWidth,
      this.borderColor = AppColors.grayLineOpacity,
      this.backgroundColor = AppColors.whiteColor,
      this.padding,
      this.margin,
      this.topLeftRadius = Radius.zero,
      this.topRightRadius = Radius.zero,
      this.bottomLeftRadius = Radius.zero,
      this.bottomRightRadius = const Radius.circular(Dimens.size0),
      this.elevation = 0,
      this.backgroundImageUrl})
      : super(key: key);

  final Widget child;
  final double? width;
  final double? height;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Radius topLeftRadius;
  final Radius topRightRadius;
  final Radius bottomRightRadius;
  final Radius bottomLeftRadius;
  final int elevation;
  final String? backgroundImageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        elevation: double.parse(elevation.toString()),
        clipBehavior: Clip.antiAlias,
        shape: isEmpty(backgroundImageUrl)
            ? BeveledRectangleBorder(
                side: BorderSide(
                    color: borderColor ?? Colors.transparent,
                    width: borderWidth ?? Dimens.size1),
                borderRadius: BorderRadius.only(
                    topLeft: topLeftRadius,
                    topRight: topRightRadius,
                    bottomRight: bottomRightRadius,
                    bottomLeft: bottomLeftRadius),
              )
            : null,
        child: Container(
          alignment: Alignment.center,
          decoration: isEmpty(backgroundImageUrl)
              ? BoxDecoration(
                  color: backgroundColor,
                )
              : BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImageUrl!),
                    fit: BoxFit.fill,
                  ),
                ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
