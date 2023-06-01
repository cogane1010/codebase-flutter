import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/resources/asset_image.dart';
import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/module/dashboard/view_model/dashboard_view_model.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    Key? key,
  }) : super(key: key);

  BottomNavigationBarItem _icons(
    String activeIcon,
    String inactiveIcon,
    String label,
  ) {
    return BottomNavigationBarItem(
        backgroundColor: Colors.transparent,
        icon: SvgPicture.asset(
          inactiveIcon,
          width: Dimens.size26,
          height: Dimens.size26,
          color: Colors.black,
          fit: BoxFit.contain,
        ),
        activeIcon: SvgPicture.asset(
          activeIcon,
          width: Dimens.size26,
          height: Dimens.size26,
          color: AppColors.appBarColor,
          fit: BoxFit.contain,
        ),
        label: label);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage(bg_hot_line), fit: BoxFit.fill),
      ),
      child: Consumer<DashBoardViewModel>(
        builder: (context, vm, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            currentIndex: vm.indexSelectPage,
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.appBarColor,
            unselectedItemColor: Colors.black38,
            elevation: 0,
            items: [
              _icons(ic_home_page, ic_home_page,
                  AppLocalizations.of(context)!.translate("home")),
              _icons(ic_booking, ic_booking,
                  AppLocalizations.of(context)!.translate("booking")),
              _icons(ic_notification, ic_notification,
                  AppLocalizations.of(context)!.translate("notification")),
              _icons(ic_settings, ic_settings,
                  AppLocalizations.of(context)!.translate("settings")),
            ],
            onTap: (index) {
              vm.selectedPage(index);
            },
          );
        },
      ),
    );
  }
}
