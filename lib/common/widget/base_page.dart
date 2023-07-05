import 'package:brg_management/resources/color.dart';
import 'package:brg_management/resources/asset_image.dart';
import 'package:flutter/material.dart';

import '../../resources/dimens.dart';
import 'navigation_drawer_widget.dart';

class BasePage extends StatelessWidget {
  final Widget pageTitle;
  final Widget body;
  final List<Widget> actions;
  final Color backgroundColor;
  final offBackAction;
  final backAction;
  final bottomNavigationBar;

  const BasePage({
    required this.pageTitle,
    required this.body,
    this.actions = const [],
    this.backgroundColor = Colors.white,
    this.offBackAction = false,
    this.backAction,
    this.bottomNavigationBar,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavigationDrawerWidget(),
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      appBar: AppBar(
        //title: pageTitle,
        centerTitle: true,
        backgroundColor: AppColors.appBar1Color,
        flexibleSpace: Image(
          image: AssetImage(tab_todo),
          fit: BoxFit.fill,
        ),
        foregroundColor: AppColors.black,
        toolbarHeight: Dimens.size50,
      ),

      // appBar: AppBar(
      //   title: pageTitle,
      //   centerTitle: true,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       color: AppColors.appBarColor,
      //       // png: DecorationImage(
      //       //   png: AssetImage('assets/images/bg_app_bar.png'),
      //       //   fit: BoxFit.cover,
      //       // ),
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   actions: actions,
      //   leading: IconButton(
      //     icon: Icon(
      //       offBackAction ? null : Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //     onPressed: offBackAction
      //         ? null
      //         : backAction ??
      //             () {
      //               Navigator.pop(context);
      //             },
      //   ),
      // ),
      body: WillPopScope(
          onWillPop: () async {
            // You can do some work here.
            // Returning true allows the pop to happen, returning false prevents it.
            return !offBackAction;
          },
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bg_tmp),
                  fit: BoxFit.cover,
                ),
              ),
              child: body)),
    );
  }
}
