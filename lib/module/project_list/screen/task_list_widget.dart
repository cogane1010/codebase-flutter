import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/app_localizations.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/isEmpty.dart';
import '../../../data/model/ProjectListModel.dart';
import '../../../resources/color.dart';
import '../view_model/task_list_vm.dart';
import 'itemTaskWidget.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({Key? key}) : super(key: key);

  @override
  _TaskListWidgetState createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  var viewModel;
  var isMenu = false;
  var toDoListType = '';
  var bartitle = false;
  int? selectedIndex;
  int? selectedStatus;
  List<StatusModel> statusList = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<TaskListViewModel>(context, listen: false);
      viewModel.initListener();
      final Object? data = ModalRoute.of(context)?.settings.arguments;
      if (data is Map) {
        if (!isEmpty(data["isMenu"])) {
          this.isMenu = data["isMenu"];
        } else {
          this.isMenu = false;
        }
        if (!isEmpty(data["toDoListType"])) {
          this.toDoListType = data["toDoListType"];
        } else {
          this.toDoListType = '';
        }
        if (data["toDoListType"] == 'ListProgressApproval') {
          this.bartitle = true;
        } else {
          this.bartitle = false;
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
            title: Text(this.bartitle
                ? AppLocalizations.of(context)!
                    .translate('danh_sach_hoan_thanh')
                : AppLocalizations.of(context)!
                    .translate('danh_sach_cong_viec_phat_sinh')),
            actions: [
              Visibility(
                visible: isMenu,
                child: PopupMenuButton<StatusModel>(
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
                            Text(AppLocalizations.of(context)!
                                .translate(choice.NameStatus!.toLowerCase())),
                            selectedIndex == index
                                ? Icon(
                                    Icons.done,
                                    color: AppColor.redMax,
                                  )
                                : SizedBox(),
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
              return ItemTaskWidget(true, viewModel.taskInfos[index], viewModel,
                  viewModel.toDoListType);
            },
            itemCount: isEmpty(viewModel) ? 0 : viewModel.taskInfos.length,
          ),
        )
        // body: Consumer<TaskListViewModel>(
        //   builder: (context, vm, child) {
        //     return Consumer<TaskListViewModel>(
        //       builder: (context, vm, child) {
        //         return SingleChildScrollView(
        //             child: Container(
        //           decoration: BoxDecoration(
        //             image: DecorationImage(
        //                 image: AssetImage(bg_login), fit: BoxFit.fill),
        //           ),
        //           child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisSize: MainAxisSize.max,
        //               children: [
        //                 Row(
        //                   children: [
        //                     Expanded(
        //                       child: SizedBox(
        //                         height: 600.0,
        //                         width: double.infinity,
        //                         child: ListView.builder(
        //                             itemCount: vm.taskInfos.length,
        //                             shrinkWrap: true,
        //                             //physics: NeverScrollableScrollPhysics(),
        //                             itemBuilder: (ctx, index) {
        //                               return ItemTaskWidget(
        //                                   true,
        //                                   vm.taskInfos[index],
        //                                   vm,
        //                                   vm.toDoListType);
        //                             }),
        //                       ),
        //                     )
        //                   ],
        //                 )
        //               ]),
        //         ));
        //       },
        //     );
        //   },
        // ),
        );
  }
}
