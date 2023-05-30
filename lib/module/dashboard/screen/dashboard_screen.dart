import 'package:brg_management/common/widget/base_page.dart';
import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/module/dashboard/view_model/dashboard_view_model.dart';
import 'package:brg_management/module/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/router.dart';
import '../../../core/utils/screen_util.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key, this.indexPage = 0}) : super(key: key);
  final int indexPage;
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late List<Widget> _pagesOptions;
  late List<String> _titlesOptions;
  late DashBoardViewModel dashBoardViewModel;

  @override
  void initState() {
    _pagesOptions = <Widget>[
      HomeScreen(),
      // BookingHistoryScreen(),
      // NotificationScreen(),
      // SettingsScreen(),
    ];
    dashBoardViewModel =
        Provider.of<DashBoardViewModel>(context, listen: false);
    dashBoardViewModel.initViewModel();
    dashBoardViewModel.indexSelectPage = widget.indexPage;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;

      if (!isEmpty(args)) {
        ScreenUtils.openScreenWithData(
            context, AppRouter.changePassword, args!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _titlesOptions = <String>[
      'BRG GROUP',
      AppLocalizations.of(context)!.translate("booking_history"),
      AppLocalizations.of(context)!.translate("notification"),
      AppLocalizations.of(context)!.translate("settings"),
    ];
    return Consumer<DashBoardViewModel>(
      builder: (context, vm, child) {
        return BasePage(
          offBackAction: true,
          pageTitle: Text(_titlesOptions.elementAt(vm.indexSelectPage)),
          body: _pagesOptions.elementAt(vm.indexSelectPage),
          //bottomNavigationBar: BottomNavigation(),
          actions: [
            // Visibility(
            //   visible: vm.indexSelectPage == 0 || vm.indexSelectPage == 1,
            //   child: GestureDetector(
            //       onTap: () {
            //         supportDialog(context);
            //       },
            //       child: SvgPicture.asset(
            //         ic_support,
            //         width: 30,
            //         height: 30,
            //         color: Colors.white,
            //       )),
            // ),
            SizedBox(
              width: 26,
            )
          ],
        );
      },
    );
  }
}
