import 'package:flutter/material.dart';

import '../../configs/app_localizations.dart';
import '../../core/helpers/ui_helper.dart';
import '../../core/utils/theme_util.dart';
import '../../resources/color.dart';

class PeoplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          title: Text(AppLocalizations.of(context)!
              .translate('term_and_conditions_applied')),
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
                      flex: 10,
                      child: Text(
                        "Nếu gặp sự cố khi đăng nhập vui lòng liên hệ với Helpdesk để được hỗ trợ!",
                        style: textStyleBoldTitle,
                      )),
                ],
              ),
              UiHelper.verticalBox20,
              Row(
                children: [
                  Expanded(
                      flex: 10,
                      child: Text(
                        "Hotline: (+84 24) 3939 3691 - Ext: 6969.",
                        style: textStyleBoldTitle,
                      )),
                ],
              ),
              UiHelper.verticalBox20,
              Row(
                children: [
                  Expanded(
                      flex: 10,
                      child: Text(
                        "Email: servicesdesk@brggroup.vn",
                        style: textStyleBoldTitle,
                      )),
                ],
              )
            ],
          ),
        ),
      );
}
