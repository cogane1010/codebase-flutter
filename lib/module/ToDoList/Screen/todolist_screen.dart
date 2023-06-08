import 'package:brg_management/configs/app_localizations.dart';
import 'package:brg_management/core/helpers/helpers.dart';
import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widget/base_background.dart';
import '../../../configs/router.dart';
import '../../../core/utils/screen_util.dart';
import '../../../core/utils/theme_util.dart';
import '../../../resources/asset_image.dart';
import '../../page/favourites_page.dart';
import '../../page/people_page.dart';
import '../ViewModel/todolist_vm.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late TodoListViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<TodoListViewModel>(context, listen: false);
      final Object? data = ModalRoute.of(context)?.settings.arguments;
      if (data is Map) {
        viewModel.initViewModel(data["moduleName"]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBarColor,
        title: Text(AppLocalizations.of(context)!.translate("to_do_list")),
      ),
      body: Consumer<TodoListViewModel>(
        builder: (context, vm, child) {
          return Consumer<TodoListViewModel>(
            builder: (context, vm, child) {
              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bg_login), fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UiHelper.verticalBox48,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: Dimens.size20),
                        child: BaseBackground(
                          borderWidth: Dimens.size0,
                          topLeftRadius: Radius.circular(Dimens.size5),
                          topRightRadius: Radius.circular(Dimens.size5),
                          bottomLeftRadius: Radius.circular(Dimens.size5),
                          bottomRightRadius: Radius.circular(Dimens.size5),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: 5,
                                              left: 5,
                                              right: 5,
                                            ),
                                            width: double.infinity,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: vm
                                                        .projectPendingheaderBorder,
                                                    width: 2),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        Dimens.size8),
                                                    topRight: Radius.circular(
                                                        Dimens.size8))),
                                            child: Column(
                                              children: [
                                                Text(
                                                  !isEmpty(vm.projectPending)
                                                      ? vm.projectPending!
                                                          .tittle
                                                          .toString()
                                                      : "",
                                                  style: textStyleBoldTitle,
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(),
                                              child: Center(
                                                  child: Column(
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        if (int.parse(vm
                                                                .projectPending!
                                                                .amount
                                                                .toString()) >
                                                            0) {
                                                          ScreenUtils
                                                              .openScreenWithData(
                                                                  context,
                                                                  AppRouter
                                                                      .projectListWidget,
                                                                  {
                                                                "moduleName": vm
                                                                    .projectPending!
                                                                    .moduleName
                                                                    .toString(),
                                                                "toDoListType":
                                                                    "ProjectPending"
                                                              });
                                                        }
                                                      },
                                                      child: Center(
                                                          child: Text(
                                                        !isEmpty(vm
                                                                .projectPending)
                                                            ? vm.projectPending!
                                                                .amount
                                                                .toString()
                                                            : "",
                                                        style:
                                                            textStyleBoldTitle,
                                                      )))
                                                ],
                                              )))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      UiHelper.verticalBox32,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: Dimens.size20),
                        child: BaseBackground(
                          borderWidth: Dimens.size0,
                          topLeftRadius: Radius.circular(Dimens.size5),
                          topRightRadius: Radius.circular(Dimens.size5),
                          bottomLeftRadius: Radius.circular(Dimens.size5),
                          bottomRightRadius: Radius.circular(Dimens.size5),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 5, left: 5, right: 5),
                                            width: double.infinity,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: vm
                                                        .taskProcessingApprovalheaderBorder,
                                                    width: 2),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        Dimens.size8),
                                                    topRight: Radius.circular(
                                                        Dimens.size8))),
                                            child: Column(
                                              children: [
                                                Text(
                                                  !isEmpty(vm
                                                          .taskProcessingApproval)
                                                      ? vm.taskProcessingApproval!
                                                          .tittle
                                                          .toString()
                                                      : "",
                                                  style: textStyleBoldTitle,
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          if (int.parse(vm
                                                                  .taskProcessingApproval!
                                                                  .amount
                                                                  .toString()) >
                                                              0) {
                                                            ScreenUtils
                                                                .openScreenWithData(
                                                                    context,
                                                                    AppRouter
                                                                        .taskListWidget,
                                                                    {
                                                                  "moduleName": vm
                                                                      .taskProcessingApproval!
                                                                      .moduleName
                                                                      .toString(),
                                                                  "toDoListType":
                                                                      "ListProcessingApproval"
                                                                });
                                                          }
                                                        },
                                                        child: Center(
                                                            child: Text(
                                                          !isEmpty(vm
                                                                  .taskProcessingApproval)
                                                              ? vm.taskProcessingApproval!
                                                                  .amount
                                                                  .toString()
                                                              : "",
                                                          style:
                                                              textStyleBoldTitle,
                                                        )))
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      UiHelper.verticalBox32,
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: Dimens.size20),
                        child: BaseBackground(
                          borderWidth: Dimens.size0,
                          topLeftRadius: Radius.circular(Dimens.size5),
                          topRightRadius: Radius.circular(Dimens.size5),
                          bottomLeftRadius: Radius.circular(Dimens.size5),
                          bottomRightRadius: Radius.circular(Dimens.size5),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 5, left: 5, right: 5),
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: vm
                                                        .taskProgressApprovalheaderBorder,
                                                    width: 2),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        Dimens.size8),
                                                    topRight: Radius.circular(
                                                        Dimens.size8))),
                                            child: Column(
                                              children: [
                                                Text(
                                                  !isEmpty(vm
                                                          .taskProgressApproval)
                                                      ? vm.taskProgressApproval!
                                                          .tittle
                                                          .toString()
                                                      : "",
                                                  style: textStyleBoldTitle,
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        if (int.parse(vm
                                                                .taskProgressApproval!
                                                                .amount
                                                                .toString()) >
                                                            0) {
                                                          ScreenUtils
                                                              .openScreenWithData(
                                                                  context,
                                                                  AppRouter
                                                                      .taskListWidget,
                                                                  {
                                                                "moduleName": vm
                                                                    .taskProgressApproval!
                                                                    .moduleName
                                                                    .toString(),
                                                                "toDoListType":
                                                                    "ListProgressApproval"
                                                              });
                                                        }
                                                      },
                                                      child: Center(
                                                          child: Text(
                                                        !isEmpty(vm
                                                                .taskProgressApproval)
                                                            ? vm.taskProgressApproval!
                                                                .amount
                                                                .toString()
                                                            : "",
                                                        style:
                                                            textStyleBoldTitle,
                                                      )))
                                                ],
                                              ),
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
                      ),
                      UiHelper.verticalBox300,
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
