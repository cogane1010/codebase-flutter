import 'package:flutter/material.dart';

import '../../configs/app_localizations.dart';
import '../../core/helpers/ui_helper.dart';
import '../../core/utils/theme_util.dart';
import '../../data/local/user_session.dart';
import '../../resources/color.dart';

class UserPage extends StatelessWidget {
  final String name;
  final String urlImage;

  const UserPage({
    Key? key,
    required this.name,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
            AppLocalizations.of(context)!.translate('thong_tin_nguoi_dung')),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            UiHelper.verticalBox100,
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      AppLocalizations.of(context)!.translate('ho_ten'),
                      style: textStyleBoldTitle,
                    )),
                UiHelper.horizontalBox4,
                Expanded(
                    flex: 6,
                    child: Text(
                      UserSession.instance.fullName ?? "",
                      style: textStyleBoldTitle,
                    ))
              ],
            ),
            UiHelper.verticalBox12,
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      AppLocalizations.of(context)!.translate('email') + ":",
                      style: textStyleBoldTitle,
                    )),
                UiHelper.horizontalBox4,
                Expanded(
                    flex: 6,
                    child: Text(
                      UserSession.instance.email ?? "",
                      style: textStyleBoldTitle,
                    ))
              ],
            ),
            UiHelper.verticalBox12,
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      AppLocalizations.of(context)!.translate('don_vi'),
                      style: textStyleBoldTitle,
                    )),
                UiHelper.horizontalBox4,
                Expanded(
                    flex: 6,
                    child: Text(
                      UserSession.instance.orgName ?? "",
                      style: textStyleBoldTitle,
                    ))
              ],
            )
          ],
        ),
      ));
}
