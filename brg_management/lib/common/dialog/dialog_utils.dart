import 'package:brg_management/common/widget/base_background.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/isEmpty.dart';
import '../widget/base_button.dart';

Future<void> showSelectPhotoDialog(BuildContext context,
    {Function(String?)? handlePickedFile}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: Dimens.size16),
            child: Text(
              AppLocalizations.of(context)!.translate("select_a_photo"),
              style: TextStyle(color: Colors.black),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  onTap: () async {
                    final file = await pickImage(ImageSource.camera);
                    if (handlePickedFile == null) {
                      Navigator.pop(context);
                      return;
                    }
                    handlePickedFile(file);
                    Navigator.pop(context);
                  },
                  title: Text(
                    AppLocalizations.of(context)!.translate("take_photo"),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    final file = await pickImage(ImageSource.gallery);
                    if (handlePickedFile == null) {
                      Navigator.pop(context);
                      return;
                    }
                    handlePickedFile(file);
                    Navigator.pop(context);
                  },
                  title: Text(
                    AppLocalizations.of(context)!
                        .translate("choose_from_library"),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Padding(
                padding: UiHelper.edgeInsetAll8,
                child: Text(
                  AppLocalizations.of(context)!
                      .translate("cancel")
                      .toUpperCase(),
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        );
      });
}

Future<String?> pickImage(ImageSource imageSource,
    {double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear}) async {
  final ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(
      source: imageSource,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality
      //preferredCameraDevice: preferredCameraDevice
      );
  return image?.path;
}

Future showSuccessDialog(BuildContext context,
    {String? message, Function? onDismiss}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.symmetric(horizontal: Dimens.size16),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          if (onDismiss != null) {
                            onDismiss();
                          }
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ))),
                Container(
                  child: BaseBackground(
                    width: MediaQuery.of(context).size.width,
                    borderColor: Colors.grey,
                    backgroundColor: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UiHelper.verticalBox16,
                        Padding(
                          padding: UiHelper.horizontalEdge8,
                          child: Text(
                            message ??
                                AppLocalizations.of(context)!
                                    .translate("successful"),
                            style: TextStyle(fontSize: Dimens.size20),
                          ),
                        ),
                        UiHelper.verticalBox32,
                        UiHelper.verticalBox8,
                        Container(
                            width: Dimens.size40,
                            height: Dimens.size40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)),
                            child: Icon(
                              Icons.check,
                              color: Colors.red,
                            )),
                        UiHelper.verticalBox32,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Future showRegisterMembershipSuccessfulDialog(BuildContext context,
    {String? title, String? message, Function? onDismiss}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.symmetric(horizontal: Dimens.size16),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          if (onDismiss != null) {
                            onDismiss();
                          }
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ))),
                Container(
                  child: BaseBackground(
                    width: MediaQuery.of(context).size.width,
                    borderColor: Colors.grey,
                    backgroundColor: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UiHelper.verticalBox16,
                        Padding(
                          padding: UiHelper.horizontalEdge8,
                          child: Text(
                            title ??
                                AppLocalizations.of(context)!
                                    .translate("successful"),
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: Dimens.size18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        UiHelper.verticalBox32,
                        Padding(
                          padding: UiHelper.horizontalEdge8,
                          child: Text(
                            message ??
                                "${AppLocalizations.of(context)!.translate(
                                  "successful",
                                )}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: Dimens.size14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        UiHelper.verticalBox8,
                        UiHelper.verticalBox32,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Future<bool> showNotification(BuildContext context, String message,
    {VoidCallback? callback}) async {
  bool isResult = false;

  showDialog(
    context: context,
    barrierDismissible: true, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
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
                size: 26,
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
                        AppLocalizations.of(context)!.translate('notification'),
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: Dimens.size18,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      UiHelper.verticalBox20,
                      Text(
                        message,
                        style: TextStyle(
                            color: AppColors.black, fontSize: Dimens.size12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        left: Dimens.size4,
                        right: Dimens.size4,
                        bottom: Dimens.size6,
                        top: 62),
                    child: BaseButton(
                      elevation: 50,
                      height: 60,
                      style:
                          TextStyle(fontSize: 14, color: AppColors.whiteColor),
                      color: AppColors.whiteColor,
                      assetImage: 'assets/png/bg_app_button.png',
                      lineColor: AppColors.whiteColor,
                      text: AppLocalizations.of(context)!
                                  .locale
                                  .languageCode
                                  .toString() ==
                              'en'
                          ? AppLocalizations.of(context)!
                              .translate('confirm')
                              .toUpperCase()
                          : AppLocalizations.of(context)!.translate('confirm'),
                      onPressed: callback ??
                          () {
                            Navigator.pop(context);
                          },
                    ),
                  )
                ],
              ),
            ),
          ],
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
