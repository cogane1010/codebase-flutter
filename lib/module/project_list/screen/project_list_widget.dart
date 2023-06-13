import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../configs/app_localizations.dart';
import '../../../core/utils/app_color.dart';
import '../../../data/model/ProjectListModel.dart';
import '../../../resources/asset_image.dart';
import '../../../resources/color.dart';
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
        super.setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    viewModel.clear();
    super.dispose();
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
                  onSelected: (c) {
                    viewModel.eventChangeStatus(c.ValueStatus.toString());
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
        body: Consumer<ProjectListViewModel>(
          builder: (context, vm, child) {
            return Consumer<ProjectListViewModel>(
              builder: (context, vm, child) {
                return SingleChildScrollView(
                    child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(bg_login), fit: BoxFit.fill),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 600.0,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    return ItemProjectWidget(
                                        true, vm.projectInfos[index], vm);
                                  },
                                  itemCount: vm.projectInfos.length,
                                ),
                              ),
                            )
                          ],
                        )
                      ]),
                ));
              },
            );
          },
        ));
  }
}
