import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/app_localizations.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/theme_util.dart';
import '../../../data/model/ProjectListModel.dart';
import '../../../resources/color.dart';
import '../../../resources/dimens.dart';
import '../view_model/project_list_vm.dart';
import 'itemProjectWidget.dart';

class ProjectListWidget extends StatefulWidget {
  const ProjectListWidget({Key? key}) : super(key: key);

  @override
  _ProjectListWidgetState createState() => _ProjectListWidgetState();
}

class _ProjectListWidgetState extends State<ProjectListWidget> {
  var viewModel;
  var isMenu = false;
  var toDoListType = '';
  var bartitle = false;
  int? selectedIndex;
  int? selectedStatus;
  List<StatusModel> statusList = [];
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<ProjectListViewModel>(context, listen: false);
      viewModel.initListener();
      final Object? data = ModalRoute.of(context)?.settings.arguments;
      if (data is Map) {
        if (!isEmpty(data["isMenu"])) {
          this.isMenu = data["isMenu"];
        } else {
          this.isMenu = false;
        }
        viewModel.initViewModel(
            ModuleName: data["moduleName"],
            ToDoListType: data["toDoListType"],
            IsMenu: data["isMenu"]);
        this.statusList = viewModel.statuses;
        if (mounted) setState(() {});
        _refreshController.requestRefresh();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    viewModel.clear();
    super.dispose();
  }

  void _onRefresh() async {
    if (mounted)
      setState(() {
        viewModel.eventChangeStatus('');
      });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted)
      setState(() {
        viewModel.eventChangeStatus('');
      });
    _refreshController.loadComplete();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.appBarColor,
            title: Text("Dự án chờ duyệt"),
            actions: [
              Visibility(
                visible: isMenu,
                child: PopupMenuButton<StatusModel>(
                  constraints:
                      const BoxConstraints.expand(width: 160, height: 220),
                  onSelected: (c) {
                    viewModel.eventChangeStatus(c.ValueStatus.toString());
                    setState(() {});
                    _refreshController.requestRefresh();
                  },
                  itemBuilder: (BuildContext context) {
                    return this.statusList.map((StatusModel choice) {
                      var index = this.statusList.indexOf(choice);
                      return PopupMenuItem<StatusModel>(
                        value: choice,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 125.0,
                                height: 25.0,
                                padding: EdgeInsets.only(
                                    left: Dimens.size10,
                                    right: Dimens.size5,
                                    bottom: Dimens.size2,
                                    top: Dimens.size2),
                                decoration: BoxDecoration(
                                    color: index == 0
                                        ? AppColors.greenColor
                                        : index == 1
                                            ? AppColors.blueColor
                                            : index == 2
                                                ? AppColors.lightBlueColor
                                                : AppColors.pinkColor,
                                    border: Border.all(
                                      color: AppColors.grayLineOpacity,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.translate(
                                        choice.NameStatus!.toLowerCase()),
                                    style: textStyleBoldTitle,
                                  ),
                                )),
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
              )
            ]),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return ItemProjectWidget(
                  true, viewModel.projectInfos[index], viewModel);
            },
            itemCount: isEmpty(viewModel) ? 0 : viewModel.projectInfos.length,
          ),
        )
        // body: Consumer<ProjectListViewModel>(
        //   builder: (context, vm, child) {
        //     return SingleChildScrollView(
        //         child: Row(
        //       children: [
        //         Expanded(
        //           child: SizedBox(
        //             height: 600.0,
        //             width: double.infinity,
        //             child: ListView.builder(
        //               itemBuilder: (ctx, index) {
        //                 return ItemProjectWidget(
        //                     true, vm.projectInfos[index], vm);
        //               },
        //               itemCount: vm.projectInfos.length,
        //             ),
        //           ),
        //         )
        //       ],
        //     ));
        //   },
        // )
        );
  }
}
