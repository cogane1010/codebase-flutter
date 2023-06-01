import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widget/base_background.dart';
import '../../../configs/app_localizations.dart';
import '../../../core/helpers/ui_helper.dart';
import '../../../core/utils/isEmpty.dart';
import '../../../core/utils/theme_util.dart';
import '../../../data/model/ProjectListModel.dart';
import '../../../resources/asset_image.dart';
import '../../../resources/color.dart';
import '../../../resources/dimens.dart';
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
        title: Text(this.bartitle
            ? AppLocalizations.of(context)!.translate('danh_sach_hoan_thanh')
            : AppLocalizations.of(context)!
                .translate('danh_sach_cong_viec_phat_sinh')),
      ),
      body: Consumer<TaskListViewModel>(
        builder: (context, vm, child) {
          return Consumer<TaskListViewModel>(
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
                      Visibility(
                          visible: isMenu,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: buildStatusWidget(context, vm),
                          )),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 600.0,
                              width: double.infinity,
                              child: ListView.builder(
                                  itemCount: vm.taskInfos.length,
                                  shrinkWrap: true,
                                  //physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (ctx, index) {
                                    return ItemTaskWidget(
                                        true,
                                        vm.taskInfos[index],
                                        vm,
                                        vm.toDoListType);
                                  }),
                            ),
                          )
                        ],
                      )
                    ]),
              ));
            },
          );
        },
      ),
    );
  }

  buildStatusWidget(BuildContext context, TaskListViewModel vm) {
    //String dropdownValue = vm.statuses.first.ValueStatus!;
    return BaseBackground(
      width: Dimens.size180,
      height: Dimens.size40,
      borderColor: Colors.grey,
      backgroundColor: Colors.white,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
            value: vm.selectedStatus,
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            style: textStyleSmallContent,
            onChanged: (String? newValue) {
              print("status combobox:" + newValue.toString());
              setState(() {
                vm.selectedStatus = newValue!;
                print("selectedStatus " + vm.selectedStatus!);
              });
              vm.eventChangeStatus(newValue.toString());
            },
            items: vm.statuses
                .map<DropdownMenuItem<String>>(
                    (value) => DropdownMenuItem<String>(
                          value: value.ValueStatus,
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate(value.NameStatus!.toLowerCase()),
                          ),
                        ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
