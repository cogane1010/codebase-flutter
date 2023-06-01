import 'package:brg_management/common/widget/base_background.dart';
import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';

import 'custom_clip_path.dart';

class BaseTextField extends StatelessWidget {
  final String? hintText;
  final Color textColor;
  final Color hintColor;
  final String? prefixIconPath;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconLeftColor;
  final String? backgroundImageAsset;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final InputDecoration? decoration;
  final TextStyle? style;
  final double height;
  final String obscuringCharacter;
  final TextAlignVertical? textAlignVertical;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final Widget? suffixIcon;
  final bool enable;
  final setImageNotBackground;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final errorStyle;

  const BaseTextField(
      {Key? key,
      this.hintText,
      this.textColor = AppColors.black,
      this.hintColor = AppColors.black,
      this.prefixIconPath,
      this.backgroundColor = Colors.white,
      this.borderColor = AppColors.grayTextColor3,
      this.iconLeftColor = Colors.black,
      this.backgroundImageAsset,
      this.controller,
      this.style,
      this.maxLength,
      this.keyboardType,
      this.obscureText = false,
      this.obscuringCharacter = '•',
      this.textAlignVertical,
      this.decoration,
      this.height = Dimens.size45,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.suffixIcon,
      this.enable = true,
      this.setImageNotBackground,
      this.initialValue,
      this.errorStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isEmpty(setImageNotBackground)
            ? BaseBackground(
                backgroundColor: backgroundColor,
                backgroundImageUrl: backgroundImageAsset,
                width: MediaQuery.of(context).size.width,
                height: height,
                borderColor: borderColor,
                child: SizedBox())
            : Image.asset(setImageNotBackground),
        TextFormField(
            enabled: this.enable,
            textAlignVertical: this.textAlignVertical,
            maxLength: this.maxLength,
            keyboardType: this.keyboardType,
            controller: controller,
            style: style ?? TextStyle(color: textColor, fontSize: 16),
            obscureText: this.obscureText,
            onSaved: onSaved ?? null,
            onChanged: onChanged,
            validator: validator ?? null,
            obscuringCharacter: this.obscuringCharacter,
            initialValue: initialValue,
            scrollPadding: EdgeInsets.only(bottom: 80),
            decoration: this.decoration ??
                InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0, left: 6),
                    errorStyle: errorStyle ?? TextStyle(color: Colors.red[400]),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    isDense: false,
                    hintText: isEmpty(hintText) ? '' : hintText,
                    hintStyle: style ??
                        TextStyle(color: hintColor, fontSize: 16, height: 0.5),
                    suffixIcon: suffixIcon,
                    prefixIcon: isEmpty(prefixIconPath)
                        ? null
                        : IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              prefixIconPath!,
                              width: 22,
                              height: 22,
                            ),
                          ))),
      ],
    );
  }
}

class BackgroundTexField extends StatelessWidget {
  const BackgroundTexField({
    Key? key,
    required this.textField,
    this.backgroundColor = Colors.white,
    this.lineColor = Colors.black,
    this.backgroundImageAsset,
    this.height = Dimens.size45,
  }) : super(key: key);
  final TextFormField textField;
  final Color backgroundColor;
  final Color lineColor;
  final String? backgroundImageAsset;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
          height: height,
          color: lineColor,
          child: Padding(
            padding: const EdgeInsets.all(1.6),
            child: ClipPath(
              clipper: CustomClipPath(1),
              child: isEmpty(backgroundImageAsset)
                  ? Container(color: backgroundColor, child: textField)
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(backgroundImageAsset!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: textField),
            ),
          )),
      clipper: CustomClipPath(0),
    );
  }
}
