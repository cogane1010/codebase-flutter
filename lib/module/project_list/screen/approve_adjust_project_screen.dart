import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/dialog/popup_notif.dart';
import '../../../common/widget/base_background.dart';
import '../../../configs/app_localizations.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/date_time.dart';
import '../../../core/utils/theme_util.dart';
import '../../../data/model/ProjectListModel.dart';
import '../view_model/task_list_vm.dart';
import 'itemAdjustTaskWidget.dart';
import 'itemTaskWidget.dart';

class ApproveAdjustProjectScreen extends StatefulWidget {
  late final TaskInfo? taskInfo;

  @override
  _ApproveAdjustProjectScreenState createState() =>
      _ApproveAdjustProjectScreenState();
}

class _ApproveAdjustProjectScreenState
    extends State<ApproveAdjustProjectScreen> {
  late String bookingId;
  TaskInfo? taskInfo;
  String? C_Approval_Request_Id;
  String? ModuleName;
  String? TodoListType;
  bool bartitle = false;

  final List<Map<String, String>> listOfColumns = [
    {"NewComplPercent": "", "ToDate": "", "StatusName": ""}
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Object? data = ModalRoute.of(context)?.settings.arguments;
      this.C_Approval_Request_Id = '';
      this.ModuleName = '';

      if (data is Map) {
        if (!isEmpty(data['C_Approval_Request_Id']) &&
            !isEmpty(data['ModuleName']) &&
            !isEmpty(data['TodoType'])) {
          C_Approval_Request_Id = data['C_Approval_Request_Id'];
          ModuleName = data['ModuleName'];
          TodoListType = data['TodoType'];
          print("C_Approval_Request_Id ${C_Approval_Request_Id}");
          print("ModuleName ${ModuleName}");
          print("RequestType ${data['RequestType']}");
          if (data['RequestType'] == Constants.TaskdealineAdj) {
            var viewModel =
                Provider.of<TaskListViewModel>(context, listen: false);
            viewModel.initAdjustDeadlineViewModel(
                C_Approval_Request_Id: this.C_Approval_Request_Id,
                ModuleName: this.ModuleName,
                ToDoListType: this.TodoListType,
                RequestType: data['RequestType']);
          } else {
            var viewModel =
                Provider.of<TaskListViewModel>(context, listen: false);
            viewModel.initDetailViewModel(
                C_Approval_Request_Id: this.C_Approval_Request_Id,
                ModuleName: this.ModuleName,
                ToDoListType: this.TodoListType);
          }
        }
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
          title: Text(AppLocalizations.of(context)!
              .translate('duyet_dieu_chinh_deadline')),
        ),
        body: Consumer<TaskListViewModel>(
          builder: (context, vm, child) {
            return SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(
                      left: Dimens.size12,
                      right: Dimens.size12,
                      top: Dimens.size16,
                      bottom: Dimens.size16),
                  height: 800.0,
                  //width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.down,
                    textDirection: TextDirection.ltr,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate('ten_du_an'),
                        style: textStyleBoldTitle,
                      ),
                      Text(
                        !isEmpty(vm.adjustProjectModel.Project)
                            ? vm.adjustProjectModel.Project!.Name.toString()
                            : "",
                        style: textStyleSmallContent,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('ngay_bat_dau'),
                                    style: textStyleBoldTitle,
                                  ),
                                  Text(
                                    !isEmpty(vm.adjustProjectModel.Project)
                                        ? "${DateTimeUtils.convertToString(vm.adjustProjectModel.Project!.StartDate)}"
                                        : "",
                                    style: textStyleContent,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('han_hoan_thanh'),
                                  style: textStyleBoldTitle,
                                ),
                                Text(
                                  !isEmpty(vm.adjustProjectModel.Project)
                                      ? "${DateTimeUtils.convertToString(vm.adjustProjectModel.Project!.StartDate)}"
                                      : "",
                                  style: textStyleContent,
                                )
                              ],
                            ))
                          ]),
                      UiHelper.verticalBox24,
                      Text(
                        AppLocalizations.of(context)!
                            .translate('danh_sach_cong_viec'),
                        style: textStyleBigBoldTitle,
                      ),
                      SizedBox(
                        height: 420,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, index) {
                            return ItemAdjustTaskWidget(
                                true,
                                vm.adjustProjectModel.Tasks?[index],
                                vm,
                                vm.toDoListType);
                          },
                          itemCount: vm.adjustProjectModel.Tasks?.length,
                        ),
                      ),
                      UiHelper.verticalBox12,
                      Visibility(
                          visible: true,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    child: buildContinueButton(context, vm),
                                  )),
                              Expanded(flex: 1, child: Container()),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    child: buildCancelButton(context, vm),
                                  ))
                            ],
                          ))
                    ],
                  )),
            );
          },
        ));
  }

  buildContinueButton(BuildContext context, TaskListViewModel vm) {
    return GestureDetector(
      onTap: () async {
        if (C_Approval_Request_Id != null) {
          confirmAlertDialog(
              title: "Xác nhận",
              content: AppLocalizations.of(context)!
                  .translate('dieu_chinh_deadline'),
              context: context,
              cancelActionText:
                  AppLocalizations.of(context)!.translate('huy_button'),
              defaultActionText: "Đồng ý",
              onPressed: () async {
                Navigator.of(context).pop();
                print("buildContinueButton: c_Project_Id   " +
                    C_Approval_Request_Id.toString());
                vm.approveOrRejectAdjustDeadline(
                    vm.moduleName.toString(),
                    C_Approval_Request_Id.toString(),
                    true,
                    "đồng ý",
                    this.TodoListType.toString());
              },
              onReturned: () async {
                Navigator.of(context).pop();
              });
        }
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        child: BaseBackground(
          height: Dimens.size45,
          borderColor: AppColors.settingIconColor,
          backgroundColor: AppColors.approveButton,
          child: Text(
            AppLocalizations.of(context)!.translate('duyet').toUpperCase(),
            //overflow: TextOverflow.ellipsis,
            style: textStyleWhiteSmallContent,
          ),
        ),
      ),
    );
  }

  buildCancelButton(BuildContext context, TaskListViewModel vm) {
    return GestureDetector(
      onTap: () async {
        if (C_Approval_Request_Id != null) {
          confirmReturnAlertDialog(
              title: "Xác nhận",
              content: AppLocalizations.of(context)!
                  .translate('dieu_chinh_deadline_false'),
              context: context,
              returnReason: vm.reasonController,
              cancelActionText:
                  AppLocalizations.of(context)!.translate('huy_button'),
              defaultActionText: "Đồng ý",
              onPressed: () async {
                Navigator.of(context).pop();
                print("buildContinueButton: c_Project_Id   " +
                    C_Approval_Request_Id.toString());
                vm.approveOrRejectAdjustDeadline(
                    vm.moduleName.toString(),
                    C_Approval_Request_Id.toString(),
                    false,
                    "không đồng ý",
                    this.TodoListType.toString());
              },
              onReturned: () async {
                Navigator.of(context).pop();
              });
        }
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        child: BaseBackground(
          height: Dimens.size45,
          borderColor: AppColors.settingIconColor,
          backgroundColor: AppColors.settingIconColor,
          child: Text(
            AppLocalizations.of(context)!.translate('tra_lai').toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: textStyleWhiteSmallContent,
          ),
        ),
      ),
    );
  }
}
