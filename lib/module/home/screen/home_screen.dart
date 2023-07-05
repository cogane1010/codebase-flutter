import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/module/home/view_model/home_vm.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widget/base_background.dart';
import '../../../configs/router.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/screen_util.dart';
import '../../../data/local/user_session.dart';
import '../../../resources/asset_image.dart';
import '../../page/favourites_page.dart';
import '../../page/people_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel homeViewModel;

  @override
  void initState() {
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.initViewModel();
    //homeViewModel.getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, vm, child) {
          return Consumer<HomeViewModel>(
            builder: (context, vm, child) {
              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bg_home), fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UiHelper.verticalBox100,
                      Visibility(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 0,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: Dimens.size20),
                        child: BaseBackground(
                          borderColor: AppColors.whiteColor,
                          elevation: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(Dimens.size0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            child: Column(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            Dimens.size0),
                                                    child: Row(children: [
                                                      UiHelper.horizontalBox8,
                                                      Icon(
                                                        Icons.build,
                                                        size: Dimens.size28,
                                                        color: AppColors
                                                            .appBarColor,
                                                      ),
                                                      TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                                  fixedSize:
                                                                      const Size(
                                                                          200,
                                                                          50)),
                                                          onPressed: () {
                                                            if (vm
                                                                    .homeData!
                                                                    .moduleData
                                                                    .length >
                                                                0) {
                                                              UserSession
                                                                      .instance
                                                                      .selectedModule =
                                                                  vm
                                                                      .homeData!
                                                                      .moduleData[
                                                                          0]
                                                                      .moduleName
                                                                      .toString();
                                                              ScreenUtils
                                                                  .openScreenWithData(
                                                                      context,
                                                                      AppRouter
                                                                          .todoList,
                                                                      {
                                                                    "moduleName": vm
                                                                        .homeData!
                                                                        .moduleData[
                                                                            0]
                                                                        .moduleName
                                                                  });
                                                            }
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                vm.homeData!.moduleData
                                                                            .length >
                                                                        0
                                                                    ? vm
                                                                        .homeData!
                                                                        .moduleData[
                                                                            0]
                                                                        .tittle
                                                                        .toString()
                                                                    : "",
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .textColor,
                                                                    fontSize: Dimens
                                                                        .size20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                              )
                                                            ],
                                                          ))
                                                    ]))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(color: AppColors.black),
                            ],
                          ),
                        ),
                      )),
                      Visibility(
                          visible: vm.homeData!.moduleData.length > 1,
                          child: Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: Dimens.size20),
                            child: BaseBackground(
                              borderColor: AppColors.whiteColor,
                              elevation: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(Dimens.size0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(
                                                                Dimens.size0),
                                                        child: Row(children: [
                                                          UiHelper
                                                              .horizontalBox8,
                                                          Icon(
                                                            Icons.business,
                                                            size: Dimens.size28,
                                                            color: AppColors
                                                                .appBarColor,
                                                          ),
                                                          TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                      fixedSize:
                                                                          const Size(
                                                                              200,
                                                                              50)),
                                                              onPressed: () {
                                                                if (vm
                                                                        .homeData!
                                                                        .moduleData
                                                                        .length >
                                                                    1) {
                                                                  UserSession.instance.selectedModule = vm
                                                                      .homeData!
                                                                      .moduleData[
                                                                          1]
                                                                      .moduleName
                                                                      .toString();
                                                                  ScreenUtils.openScreenWithData(
                                                                      context,
                                                                      AppRouter
                                                                          .todoList,
                                                                      {
                                                                        "moduleName": vm
                                                                            .homeData!
                                                                            .moduleData[1]
                                                                            .moduleName
                                                                      });
                                                                }
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    vm.homeData!.moduleData.length >
                                                                            1
                                                                        ? vm
                                                                            .homeData!
                                                                            .moduleData[1]
                                                                            .tittle
                                                                            .toString()
                                                                        : "",
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .textColor,
                                                                        fontSize:
                                                                            Dimens
                                                                                .size20,
                                                                        fontWeight:
                                                                            FontWeight.w900),
                                                                  )
                                                                ],
                                                              ))
                                                        ]))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(color: AppColors.black),
                                ],
                              ),
                            ),
                          )),
                      Visibility(
                          visible: vm.homeData!.moduleData.length > 2,
                          child: Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: Dimens.size20),
                            child: BaseBackground(
                              borderColor: AppColors.whiteColor,
                              elevation: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(Dimens.size0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.white),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .all(
                                                                Dimens.size0),
                                                        child: Row(children: [
                                                          UiHelper
                                                              .horizontalBox8,
                                                          Icon(
                                                            Icons.assignment,
                                                            size: Dimens.size28,
                                                            color: AppColors
                                                                .appBarColor,
                                                          ),
                                                          TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                      fixedSize:
                                                                          const Size(
                                                                              200,
                                                                              50)),
                                                              onPressed: () {
                                                                if (vm
                                                                        .homeData!
                                                                        .moduleData
                                                                        .length >
                                                                    2) {
                                                                  UserSession.instance.selectedModule = vm
                                                                      .homeData!
                                                                      .moduleData[
                                                                          2]
                                                                      .moduleName
                                                                      .toString();
                                                                  ScreenUtils.openScreenWithData(
                                                                      context,
                                                                      AppRouter
                                                                          .todoList,
                                                                      {
                                                                        "moduleName": vm
                                                                            .homeData!
                                                                            .moduleData[2]
                                                                            .moduleName
                                                                      });
                                                                }
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    vm.homeData!.moduleData.length >
                                                                            2
                                                                        ? vm
                                                                            .homeData!
                                                                            .moduleData[2]
                                                                            .tittle
                                                                            .toString()
                                                                        : "",
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .textColor,
                                                                        fontSize:
                                                                            Dimens
                                                                                .size20,
                                                                        fontWeight:
                                                                            FontWeight.w900),
                                                                  )
                                                                ],
                                                              ))
                                                        ]))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      UiHelper.verticalBox400,
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildBottomMenuItem({
    required String text,
    IconData? icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PeoplePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavouritesPage(),
        ));
        break;
    }
  }
}
