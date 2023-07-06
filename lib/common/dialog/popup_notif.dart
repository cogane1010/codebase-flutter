import 'dart:io';

import 'package:brg_management/common/widget/base_background.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/helpers/ui_helper.dart';
import 'package:brg_management/core/utils/theme_util.dart';
import 'package:brg_management/resources/color.dart';
import 'package:brg_management/resources/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showAlertDialog(
    {required BuildContext context,
    required String content,
    String? title,
    String? cancelActionText,
    required String defaultActionText,
    VoidCallback? onPressed,
    VoidCallback? onDismiss}) async {
  if (!Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
            child: Text(
          title ?? AppLocalizations.of(context)!.translate('notification'),
          style: textStyleSmallBoldTitle,
        )),
        content: Text(content, style: textStyleSmallTitle),
        actions: <Widget>[
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  // give it width
                  Expanded(
                    child: GestureDetector(
                      onTap: onPressed ?? () => Navigator.of(context).pop(true),
                      child: BaseBackground(
                        padding: EdgeInsets.symmetric(vertical: Dimens.size12),
                        topLeftRadius: Radius.circular(Dimens.size5),
                        bottomRightRadius: Radius.circular(Dimens.size5),
                        topRightRadius: Radius.circular(Dimens.size5),
                        bottomLeftRadius: Radius.circular(Dimens.size5),
                        child: Text(
                          defaultActionText,
                          style: textStyleWhiteSmallContent,
                        ),
                        borderColor: AppColors.settingIconColor,
                        backgroundColor: AppColors.settingIconColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // give it width
                  if (cancelActionText != null)
                    Expanded(
                      child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(false),
                          child: BaseBackground(
                            padding:
                                EdgeInsets.symmetric(vertical: Dimens.size12),
                            topLeftRadius: Radius.circular(Dimens.size5),
                            bottomRightRadius: Radius.circular(Dimens.size5),
                            topRightRadius: Radius.circular(Dimens.size5),
                            bottomLeftRadius: Radius.circular(Dimens.size5),
                            child: Text(
                              cancelActionText,
                              style: textStyleSmallContentOrange,
                            ),
                            borderColor: AppColors.settingIconColor,
                            backgroundColor: AppColors.whiteColor,
                          )),
                    ),
                  if (cancelActionText != null) SizedBox(width: 10),
                  // give it width
                ],
              ),
              UiHelper.verticalBox8,
            ],
          )
        ],
      ),
    ).then((value) {
      if (onDismiss != null) onDismiss();
    });
  }

  // todo : showDialog for ios
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
          title ?? AppLocalizations.of(context)!.translate('notification')),
      content: Text(content),
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: onPressed ?? () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  ).then((value) {
    if (onDismiss != null) onDismiss();
  });
}

Future confirmAlertDialog(
    {required BuildContext context,
    required String content,
    String? title,
    String? cancelActionText,
    required String defaultActionText,
    VoidCallback? onReturned,
    VoidCallback? onPressed,
    VoidCallback? onDismiss}) async {
  if (!Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
            child: Text(
          title ?? AppLocalizations.of(context)!.translate('notification'),
          style: textStyleSmallBoldTitle,
        )),
        content: Text(content, style: textStyleSmallTitle),
        actions: <Widget>[
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  // give it width
                  Expanded(
                    child: GestureDetector(
                      onTap: onPressed ?? () => Navigator.of(context).pop(true),
                      child: BaseBackground(
                        padding: EdgeInsets.symmetric(vertical: Dimens.size12),
                        topLeftRadius: Radius.circular(Dimens.size5),
                        bottomRightRadius: Radius.circular(Dimens.size5),
                        topRightRadius: Radius.circular(Dimens.size5),
                        bottomLeftRadius: Radius.circular(Dimens.size5),
                        child: Text(
                          defaultActionText,
                          style: textStyleWhiteSmallContent,
                        ),
                        borderColor: AppColors.settingIconColor,
                        backgroundColor: AppColors.settingIconColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // give it width
                  if (cancelActionText != null)
                    Expanded(
                      child: GestureDetector(
                          onTap: onReturned ??
                              () => Navigator.of(context).pop(true),
                          child: BaseBackground(
                            padding:
                                EdgeInsets.symmetric(vertical: Dimens.size12),
                            topLeftRadius: Radius.circular(Dimens.size5),
                            bottomRightRadius: Radius.circular(Dimens.size5),
                            topRightRadius: Radius.circular(Dimens.size5),
                            bottomLeftRadius: Radius.circular(Dimens.size5),
                            child: Text(
                              cancelActionText,
                              style: textStyleSmallContentOrange,
                            ),
                            borderColor: AppColors.settingIconColor,
                            backgroundColor: AppColors.whiteColor,
                          )),
                    ),
                  if (cancelActionText != null) SizedBox(width: 10),
                  // give it width
                ],
              ),
              UiHelper.verticalBox8,
            ],
          )
        ],
      ),
    ).then((value) {
      if (onDismiss != null) onDismiss();
    });
  }

  // todo : showDialog for ios
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
          title ?? AppLocalizations.of(context)!.translate('notification')),
      content: Text(content),
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: onPressed ?? () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  ).then((value) {
    if (onDismiss != null) onDismiss();
  });
}

Future confirmReturnAlertDialog(
    {required BuildContext context,
    required String content,
    String? title,
    String? cancelActionText,
    required String defaultActionText,
    TextEditingController? returnReason,
    VoidCallback? onReturned,
    VoidCallback? onPressed,
    VoidCallback? onDismiss}) async {
  if (!Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
            child: Text(
          title ?? AppLocalizations.of(context)!.translate('notification'),
          style: textStyleSmallBoldTitle,
        )),
        //content: Text(content, style: textStyleSmallTitle),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 20,
              alignment: Alignment.center,
              child: Text(content),
            ),
            Container(
              height: 80,
              alignment: Alignment.center,
              child: TextField(
                maxLines: null,
                onChanged: (value) {},
                controller: returnReason,
                decoration: InputDecoration(hintText: "Nhập lý do"),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  // give it width
                  Expanded(
                    child: GestureDetector(
                      onTap: onPressed ?? () => Navigator.of(context).pop(true),
                      child: BaseBackground(
                        padding: EdgeInsets.symmetric(vertical: Dimens.size12),
                        topLeftRadius: Radius.circular(Dimens.size5),
                        bottomRightRadius: Radius.circular(Dimens.size5),
                        topRightRadius: Radius.circular(Dimens.size5),
                        bottomLeftRadius: Radius.circular(Dimens.size5),
                        child: Text(
                          defaultActionText,
                          style: textStyleWhiteSmallContent,
                        ),
                        borderColor: AppColors.settingIconColor,
                        backgroundColor: AppColors.settingIconColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // give it width
                  if (cancelActionText != null)
                    Expanded(
                      child: GestureDetector(
                          onTap: onReturned ??
                              () => Navigator.of(context).pop(true),
                          child: BaseBackground(
                            padding:
                                EdgeInsets.symmetric(vertical: Dimens.size12),
                            topLeftRadius: Radius.circular(Dimens.size5),
                            bottomRightRadius: Radius.circular(Dimens.size5),
                            topRightRadius: Radius.circular(Dimens.size5),
                            bottomLeftRadius: Radius.circular(Dimens.size5),
                            child: Text(
                              cancelActionText,
                              style: textStyleSmallContentOrange,
                            ),
                            borderColor: AppColors.settingIconColor,
                            backgroundColor: AppColors.whiteColor,
                          )),
                    ),
                  if (cancelActionText != null) SizedBox(width: 10),
                  // give it width
                ],
              ),
              UiHelper.verticalBox8,
            ],
          )
        ],
      ),
    ).then((value) {
      if (onDismiss != null) onDismiss();
    });
  }

  // todo : showDialog for ios
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(
          title ?? AppLocalizations.of(context)!.translate('notification')),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 20,
            alignment: Alignment.center,
            child: Text(content),
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            child: TextField(
              maxLines: null,
              onChanged: (value) {},
              controller: returnReason,
              decoration: InputDecoration(hintText: "Nhập lý do"),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed: onPressed ?? () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  ).then((value) {
    if (onDismiss != null) onDismiss();
  });
}
