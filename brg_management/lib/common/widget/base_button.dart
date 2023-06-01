import 'package:brg_management/common/widget/base_background.dart';
import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';

import 'custom_clip_path.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String? assetImage;
  final Color color;
  final Color textColor;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final Color backgroundColor;
  final Color lineColor;
  final bool isClipTopLeft;
  final bool isClipBottomRight;
  final TextStyle? style;
  final double height;
  final EdgeInsetsGeometry textPadding;
  final elevation;

  const BaseButton(
      {Key? key,
      required this.text,
      this.style,
      this.icon,
      this.assetImage,
      this.onPressed,
      this.color = AppColors.settingIconColor,
      this.textColor = Colors.white,
      this.iconColor,
      this.backgroundColor = AppColors.whiteColor,
      this.lineColor = AppColors.grayTextColor3,
      this.isClipTopLeft = true,
      this.isClipBottomRight = false,
      this.height = 45,
      this.elevation = 10,
      this.textPadding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBackground(
        height: height,
        elevation: elevation,
        borderColor: lineColor,
        backgroundImageUrl: assetImage,
        backgroundColor: backgroundColor,
        topLeftRadius: Radius.circular(Dimens.size12),
        bottomRightRadius: Radius.circular(Dimens.size12),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: textPadding,
            child: Center(
              child: Text(
                text,
                // overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: style ??
                    TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.size16),
              ),
            ),
          ),
        ));
  }
}

class BackgroundButton extends StatelessWidget {
  const BackgroundButton(
      {Key? key,
      required this.body,
      this.backgroundColor = Colors.white,
      this.lineColor = Colors.grey,
      this.backgroundImageAsset,
      this.isClipTopLeft = false,
      this.isClipBottomRight = false})
      : super(key: key);
  final Widget body;
  final Color backgroundColor;
  final Color lineColor;
  final String? backgroundImageAsset;
  final bool isClipTopLeft;
  final bool isClipBottomRight;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
          height: Dimens.size45,
          color: lineColor,
          child: Padding(
            padding: const EdgeInsets.all(1.6),
            child: ClipPath(
              clipper: CustomClipPath(1,
                  isClipBottomRight: isClipBottomRight,
                  isClipTopLeft: isClipTopLeft),
              child: isEmpty(backgroundImageAsset)
                  ? Container(color: backgroundColor, child: body)
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(backgroundImageAsset!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: body),
            ),
          )),
      clipper: CustomClipPath(0,
          isClipBottomRight: isClipBottomRight, isClipTopLeft: isClipTopLeft),
    );
  }
}
