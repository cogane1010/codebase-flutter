import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/dialog/popup_notif.dart';
import '../../../common/widget/base_background.dart';
import '../../../configs/app_localizations.dart';
import '../../../configs/router.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/utils/date_time.dart';
import '../../../core/utils/theme_util.dart';
import '../../../data/model/ProjectListModel.dart';
import '../view_model/project_list_vm.dart';
import '../view_model/task_list_vm.dart';

class DetailProjectTasikScreen extends StatefulWidget {
  late final TaskInfo? taskInfo;

  @override
  _DetailProjectTaskScreenState createState() =>
      _DetailProjectTaskScreenState();
}

class _DetailProjectTaskScreenState extends State<DetailProjectTasikScreen> {
  late String bookingId;
  ProjectInfo? projectInfo;
  String? C_Approval_Request_Id;
  String? ModuleName;
  String? TodoListType;

  final List<Map<String, String>> listOfColumns = [
    {"STT": "", "Name": ""}
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Object? data = ModalRoute.of(context)?.settings.arguments;
      if (data is Map) {
        if (!isEmpty(data['C_Approval_Request_Id']) &&
            !isEmpty(data['ModuleName']) &&
            !isEmpty(data['TodoType'])) {
          this.C_Approval_Request_Id = data['C_Approval_Request_Id'];
          this.ModuleName = data['ModuleName'];
          this.TodoListType = data['TodoType'];
          print("C_Approval_Request_Id ${this.C_Approval_Request_Id}");
          print("ModuleName ${this.ModuleName}");
          print("TodoListType ${this.TodoListType}");
          if (data['TodoType'] == 'ListProcessingApproval') {
            var viewModel =
                Provider.of<TaskListViewModel>(context, listen: false);
            viewModel.initDetailProjectViewModel(
                C_Approval_Request_Id: this.C_Approval_Request_Id,
                ModuleName: this.ModuleName,
                ToDoListType: this.TodoListType);
          }
          if (data['TodoType'] == 'ProjectPending') {
            var viewModel =
                Provider.of<ProjectListViewModel>(context, listen: false);
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
        title: Text(AppLocalizations.of(context)!.translate('duyet_du_an')),
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
                        //textDirection: TextDirection.LTR,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .translate('loai_du_an'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.projectDetailModel)
                                ? vm.projectDetailModel!.Project!.Type
                                    .toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!.translate('ma_du_an'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.projectDetailModel)
                                ? vm.projectDetailModel!.Project!.Code
                                    .toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('ten_du_an'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.projectDetailModel)
                                ? vm.projectDetailModel!.Project!.Name
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
                                  height: 60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('chi_phi_thuc_hien'),
                                        style: textStyleBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.projectDetailModel)
                                            ? vm.projectDetailModel!.Project!
                                                .CostAmt
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
                                  height: 60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('trang_thai'),
                                        style: textStyleBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.projectDetailModel)
                                            ? vm.projectDetailModel!.Project!
                                                .StatusName
                                                .toString()
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
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  height: 60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('ngay_bat_dau'),
                                        style: textStyleBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.projectDetailModel)
                                            ? "${DateTimeUtils.convertToString(vm.projectDetailModel?.Project!.StartDate)}"
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
                                  height: 60,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('han_hoan_thanh'),
                                        style: textStyleBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.projectDetailModel)
                                            ? "${DateTimeUtils.convertToString(vm.projectDetailModel?.Project!.Deadline)}"
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
                            AppLocalizations.of(context)!
                                .translate('thong_tin_cong_viec'),
                            style: textStyleBigBoldTitle,
                          ),
                          Column(
                            children: [
                              DataTable(
                                columns: [
                                  DataColumn(
                                      label: Text('STT',
                                          style: textStyleBoldTitle)),
                                  DataColumn(
                                      label: Text('Tên công việc',
                                          style: textStyleBoldTitle))
                                ],
                                rows: !isEmpty(vm.projectDetailModel)
                                    ? vm.projectDetailModel!.Tasks!
                                        .map(
                                          ((element) => DataRow(
                                                cells: <DataCell>[
                                                  DataCell(
                                                      Container(
                                                        width: 10,
                                                        child: Text(element.STT
                                                            .toString()),
                                                      ),
                                                      onTap: () async {}),
                                                  DataCell(
                                                      Container(
                                                        width: 200,
                                                        child: Text(
                                                          !isEmpty(element.Name)
                                                              ? element.Name
                                                                  .toString()
                                                              : "",
                                                        ),
                                                      ), onTap: () {
                                                    print(
                                                        'projectDetailModel.Tasks');
                                                    print(element);
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            AppRouter
                                                                .detailProjectTask,
                                                            arguments: element)
                                                        .then((result) {
                                                      print(
                                                          "detailProjectTask");
                                                      print(result);
                                                    });
                                                  }),
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
                                                ],
                                              )),
                                        )
                                        .toList(),
                              )
                            ],
                          ),
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
              content:
                  "${AppLocalizations.of(context)!.translate("duyet_button_content")}",
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
                    TodoListType.toString());
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
              content:
                  "${AppLocalizations.of(context)!.translate("tra_lai_button_content")}",
              context: context,
              returnReason: vm.reasonController,
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
                    TodoListType.toString());
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
