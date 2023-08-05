import 'package:brg_management/resources/asset_image.dart';
import 'package:brg_management/core/helpers/helpers.dart';
import 'package:flutter/material.dart';

import '../../configs/app_localizations.dart';
import '../../module/page/people_page.dart';

class HotLineView extends StatelessWidget {
  const HotLineView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: Dimens.size40,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage(bg_hot_line), fit: BoxFit.cover),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PeoplePage(),
          ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/png/support_agent.png',
              width: 80,
              height: 80,
            ),
            UiHelper.horizontalBox4,
            Text(
              AppLocalizations.of(context)!
                  .translate('term_and_conditions_applied'),
              style: TextStyle(
                  fontSize: Dimens.size20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
