import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/dialog/popup_notif.dart';
import '../../../common/widget/base_background.dart';
import '../../../configs/app_localizations.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/utils/date_time.dart';
import '../../../core/utils/theme_util.dart';
import '../../../data/model/ProjectListModel.dart';
import '../view_model/task_list_vm.dart';

class ApproveDetailProjectScreen extends StatefulWidget {
  late final TaskInfo? taskInfo;

  @override
  _ApproveDetailProjectScreenState createState() =>
      _ApproveDetailProjectScreenState();
}

class _ApproveDetailProjectScreenState
    extends State<ApproveDetailProjectScreen> {
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
          var viewModel =
              Provider.of<TaskListViewModel>(context, listen: false);
          viewModel.initDetailViewModel(
              C_Approval_Request_Id: this.C_Approval_Request_Id,
              ModuleName: this.ModuleName,
              ToDoListType: this.TodoListType);
        }
        if (data['RequestType'] == 'taskcompletionapproval') {
          this.bartitle = true;
          //AppLocalizations.of(context)!.translate('duyet_hoan_thanh');
        } else {
          this.bartitle = false;
          //AppLocalizations.of(context)!.translate('duyet_tien_do');
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
        title: Text(this.bartitle
            ? AppLocalizations.of(context)!.translate('duyet_hoan_thanh')
            : AppLocalizations.of(context)!.translate('duyet_tien_do')),
      ),
      body: Consumer<TaskListViewModel>(
        builder: (context, vm, child) {
          return Consumer<TaskListViewModel>(
            builder: (context, vm, child) {
              return SingleChildScrollView(
                  child: Container(
                      margin: const EdgeInsets.only(
                          top: Dimens.size16,
                          left: Dimens.size15,
                          right: Dimens.size15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.translate('noi_dung'),
                            style: textStyleSmallBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskDetailModel.Tasks?.Name)
                                ? vm.taskDetailModel.Tasks!.Name.toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('don_vi_thuc_hien'),
                            style: textStyleSmallBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskDetailModel.Tasks?.AssignedOrgName)
                                ? vm.taskDetailModel.Tasks!.AssignedOrgName!
                                    .toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('nguoi_thuc_hien'),
                            style: textStyleSmallBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskDetailModel.Tasks?.AssignedOrgName)
                                ? vm.taskDetailModel.Tasks!.AssignedOrgName
                                    .toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('ty_trong'),
                                        style: textStyleSmallBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm
                                                .taskDetailModel.Tasks?.Density)
                                            ? vm.taskDetailModel.Tasks!.Density
                                                .toString()
                                            : "",
                                        style: textStyleContent,
                                      ),
                                      Divider(color: AppColors.grayLineOpacity)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                    height: 50,
                                    child: Container(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .translate('chi_phi'),
                                            style: textStyleSmallBoldTitle,
                                          ),
                                          Text(
                                            !isEmpty(vm.taskDetailModel.Tasks
                                                    ?.Cost)
                                                ? vm.taskDetailModel.Tasks!.Cost
                                                    .toString()
                                                : "",
                                            style: textStyleContent,
                                          ),
                                          Divider(
                                              color: AppColors.grayLineOpacity)
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('tien_do_cong_viec'),
                                        style: textStyleSmallBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.taskDetailModel.Tasks
                                                ?.PercentComplete)
                                            ? vm.taskDetailModel.Tasks!
                                                .PercentComplete
                                                .toString()
                                            : "",
                                        style: textStyleContent,
                                      ),
                                      Divider(color: AppColors.grayLineOpacity)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                    height: 50,
                                    child: Container(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .translate('muc_do_uu_tien'),
                                            style: textStyleSmallBoldTitle,
                                          ),
                                          Text(
                                            !isEmpty(vm.taskDetailModel.Tasks
                                                    ?.PriorityName)
                                                ? vm.taskDetailModel.Tasks!
                                                    .PriorityName
                                                    .toString()
                                                : "",
                                            style: textStyleContent,
                                          ),
                                          Divider(
                                              color: AppColors.grayLineOpacity)
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('trang_thai'),
                                        style: textStyleSmallBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.taskDetailModel.Tasks
                                                ?.AcceptStatusText)
                                            ? vm.taskDetailModel.Tasks!
                                                .AcceptStatusText
                                                .toString()
                                            : "",
                                        style: textStyleContent,
                                      ),
                                      Divider(color: AppColors.grayLineOpacity)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                    height: 50,
                                    child: Container(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .translate('nguoi_tao'),
                                            style: textStyleSmallBoldTitle,
                                          ),
                                          Text(
                                            !isEmpty(vm.taskDetailModel.Tasks
                                                    ?.CreatedUser)
                                                ? vm.taskDetailModel.Tasks!
                                                    .CreatedUser
                                                    .toString()
                                                : "",
                                            style: textStyleContent,
                                          ),
                                          Divider(
                                              color: AppColors.grayLineOpacity)
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('ngay_bat_dau'),
                                        style: textStyleSmallBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.taskDetailModel.Tasks
                                                ?.StartDate)
                                            ? "${DateTimeUtils.convertToString(vm.taskDetailModel.Tasks!.StartDate)}"
                                            : "",
                                        style: textStyleContent,
                                      ),
                                      Divider(color: AppColors.grayLineOpacity)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                    height: 50,
                                    child: Container(
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .translate('han_hoan_thanh'),
                                            style: textStyleSmallBoldTitle,
                                          ),
                                          Text(
                                            !isEmpty(vm.taskDetailModel.Tasks
                                                    ?.Deadline)
                                                ? "${DateTimeUtils.convertToString(vm.taskDetailModel.Tasks!.Deadline)}"
                                                : "",
                                            style: textStyleContent,
                                          ),
                                          Divider(
                                              color: AppColors.grayLineOpacity)
                                        ],
                                      ),
                                    )),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('ngay_bat_dau_thuc_te'),
                                        style: textStyleSmallBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.taskDetailModel.Tasks
                                                ?.Actual_StartDate)
                                            ? "${DateTimeUtils.convertToString(vm.taskDetailModel.Tasks!.Actual_StartDate)}"
                                            : "",
                                        style: textStyleContent,
                                      ),
                                      Divider(color: AppColors.grayLineOpacity)
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('ngay_bat_dau_thuc_te'),
                                        style: textStyleSmallBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.taskDetailModel.Tasks
                                                ?.Actual_StartDate)
                                            ? "${DateTimeUtils.convertToString(vm.taskDetailModel.Tasks!.Actual_StartDate)}"
                                            : "",
                                        style: textStyleContent,
                                      ),
                                      Divider(color: AppColors.grayLineOpacity)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(
                            AppLocalizations.of(context)!.translate('tien_do'),
                            style: textStyleBoldTitle,
                          ),
                          Column(
                            children: [
                              DataTable(
                                border: TableBorder.all(
                                  width: 1.0,
                                  color: AppColors.grayTextColor3,
                                ),
                                columnSpacing: 25,
                                columns: [
                                  DataColumn(
                                      label: Text(
                                          AppLocalizations.of(context)!
                                              .translate('tien_do'),
                                          style: textStyleSmallBoldTitle)),
                                  DataColumn(
                                      label: Text(
                                          AppLocalizations.of(context)!
                                              .translate('cap_nhat_den_ngay'),
                                          style: textStyleSmallBoldTitle)),
                                  DataColumn(
                                      label: Text(
                                          AppLocalizations.of(context)!
                                              .translate('trang_thai'),
                                          style: textStyleSmallBoldTitle))
                                ],
                                rows:
                                    !isEmpty(vm.taskDetailModel.Tasks?.Progress)
                                        ? vm.taskDetailModel.Tasks!.Progress!
                                            .map(
                                              ((element) => DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(
                                                          Container(
                                                            width: 35,
                                                            child: Text(
                                                              !isEmpty(element
                                                                      .NewComplPercent)
                                                                  ? element
                                                                          .NewComplPercent
                                                                      .toString()
                                                                  : "",
                                                            ),
                                                          ),
                                                          onTap: () async {}),
                                                      DataCell(
                                                          Container(
                                                            width: 110,
                                                            child: Text(
                                                              !isEmpty(element)
                                                                  ? "${DateTimeUtils.convertToString(element.ToDate)}"
                                                                  : "",
                                                            ),
                                                          ),
                                                          onTap: () {}),
                                                      DataCell(
                                                          Container(
                                                            width: 70,
                                                            child: Text(
                                                              !isEmpty(element
                                                                      .StatusName)
                                                                  ? element
                                                                          .StatusName
                                                                      .toString()
                                                                  : "",
                                                            ),
                                                          ),
                                                          onTap: () {})
                                                    ],
                                                  )),
                                            )
                                            .toList()
                                        : listOfColumns
                                            .map(
                                              ((element) => DataRow(
                                                    cells: <DataCell>[
                                                      DataCell(Container(
                                                        width: 10,
                                                        child: Text(""),
                                                      )),
                                                      DataCell(Container(
                                                        width: 10,
                                                        child: Text(""),
                                                      )),
                                                      DataCell(Container(
                                                        width: 10,
                                                        child: Text(""),
                                                      )),
                                                    ],
                                                  )),
                                            )
                                            .toList(),
                              )
                            ],
                          ),
                          UiHelper.verticalBox12,
                          Visibility(
                              visible: vm.isShowButton,
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
                      )));
            },
          );
        },
      ),
    );
  }

  buildContinueButton(BuildContext context, TaskListViewModel vm) {
    return GestureDetector(
      onTap: () async {
        if (C_Approval_Request_Id != null) {
          confirmAlertDialog(
              title: "Xác nhận",
              content: this.bartitle
                  ? AppLocalizations.of(context)!
                      .translate('duyet_hoan_thanh_content')
                  : AppLocalizations.of(context)!
                      .translate('duyet_tien_do_content'),
              context: context,
              cancelActionText:
                  AppLocalizations.of(context)!.translate('huy_button'),
              defaultActionText: "Đồng ý",
              onPressed: () async {
                Navigator.of(context).pop();
                print("buildContinueButton: c_Project_Id   " +
                    C_Approval_Request_Id.toString());
                vm.approveOrRejectProjectAndTask(
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
          confirmAlertDialog(
              title: "Xác nhận",
              content: AppLocalizations.of(context)!
                  .translate('tra_lai_button_content'),
              context: context,
              cancelActionText:
                  AppLocalizations.of(context)!.translate('huy_button'),
              defaultActionText: "Đồng ý",
              onPressed: () async {
                Navigator.of(context).pop();
                print("buildContinueButton: c_Project_Id   " +
                    C_Approval_Request_Id.toString());
                vm.approveOrRejectProjectAndTask(
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
