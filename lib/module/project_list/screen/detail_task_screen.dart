import 'package:brg_management/core/utils/isEmpty.dart';
import 'package:brg_management/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../configs/app_localizations.dart';
import '../../../core/helpers/helpers.dart';
import '../../../core/utils/date_time.dart';
import '../../../core/utils/theme_util.dart';
import '../../../data/model/ProjectListModel.dart';
import '../view_model/project_list_vm.dart';

class DetailTaskScreen extends StatefulWidget {
  DetailTaskScreen({Key? key}) : super(key: key);

  @override
  _DetailTaskScreenState createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  var viewModel;
  late String bookingId;
  ProjectInfo? projectInfo;
  TaskInfo? taskInfo;
  String? c_Project_Id;
  String? task_Id;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<ProjectListViewModel>(context, listen: false);
      final Object? data = ModalRoute.of(context)?.settings.arguments;
      if (!isEmpty(data)) {
        taskInfo = data as TaskInfo?;
        print("taskInfo ");
        print(data.toString());
        viewModel.initDetaiTaskViewModel(taskInfo);
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
        title:
            Text(AppLocalizations.of(context)!.translate('chi_tiet_cong_viec')),
      ),
      body: Consumer<ProjectListViewModel>(
        builder: (context, vm, child) {
          return Consumer<ProjectListViewModel>(
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
                            AppLocalizations.of(context)!
                                .translate('nhom_cong_viec'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskInfo)
                                ? vm.taskInfo.TaskTypeName.toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('ten_cong_viec'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskInfo)
                                ? vm.taskInfo.Name.toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('cong_viec_cha'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskInfo)
                                ? vm.taskInfo.ParentName.toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('don_vi_thuc_hien'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskInfo)
                                ? vm.taskInfo.AssignedOrgName.toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('nguoi_thuc_hien'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskInfo)
                                ? vm.taskInfo.AssignedUserName.toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('don_vi_ca_nhan_xac_nhan_ket_qua'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskInfo)
                                ? vm.taskInfo.ResConfirmLoc.toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('cach_thuc_ghi_nhan_ket_qua'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskInfo)
                                ? vm.taskInfo.ResConfirmMethod.toString()
                                : "",
                            style: textStyleContent,
                          ),
                          Divider(color: AppColors.grayLineOpacity),
                          Text(
                            AppLocalizations.of(context)!.translate('ghi_chu'),
                            style: textStyleBoldTitle,
                          ),
                          Text(
                            !isEmpty(vm.taskInfo)
                                ? vm.taskInfo.Note.toString()
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
                                            .translate('ty_trong'),
                                        style: textStyleBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.taskInfo)
                                            ? vm.taskInfo.Density.toString()
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
                                            .translate('chi_phi'),
                                        style: textStyleBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.taskInfo)
                                            ? vm.taskInfo.Cost.toString()
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
                                            .translate('muc_do_uu_tien'),
                                        style: textStyleBoldTitle,
                                      ),
                                      Text(
                                        !isEmpty(vm.taskInfo)
                                            ? vm.taskInfo.PriorityName
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
                                        !isEmpty(vm.taskInfo)
                                            ? vm.taskInfo.StatusName.toString()
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
                                        !isEmpty(vm.taskInfo)
                                            ? "${DateTimeUtils.convertToString(vm.taskInfo.StartDate)}"
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
                                            style: textStyleBoldTitle,
                                          ),
                                          Text(
                                            !isEmpty(vm.taskInfo)
                                                ? "${DateTimeUtils.convertToString(vm.taskInfo.Deadline)}"
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
                          )
                        ],
                      )));
            },
          );
        },
      ),
    );
  }
}
