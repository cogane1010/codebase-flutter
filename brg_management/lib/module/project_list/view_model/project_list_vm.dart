import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../common/dialog/popup_notif.dart';
import '../../../configs/app_localizations.dart';
import '../../../core/utils/convertor.dart';
import '../../../core/utils/isEmpty.dart';
import '../../../data/model/ProjectListModel.dart';
import '../../../data/model/base_response_api.dart';
import '../../../data/model/response.dart';
import '../../../data/repositories/projectListApi.dart';
import '../../../main.dart';

class ProjectListViewModel extends ChangeNotifier {
  ProjectListApi projectListApi = ProjectListApi();
  ProjectDetailModel? projectDetailModel;

  String toDoListType = 'ProjectPending';
  String? moduleName;
  String statudDefualt = "1";
  String? selectedStatus = '-1';
  BaseResponseApi? projectResponse;
  BaseResponseApi? projectDetailResponse;
  List<ProjectInfo> projectInfos = [];
  TaskInfo taskInfo = new TaskInfo();
  Color headerBorder = Convertors.hexToColor('#9f0010');
  List<StatusModel> statuses = [
    new StatusModel("-1", "all"),
    new StatusModel("2", "waiting"),
    new StatusModel("1", "approve"),
    new StatusModel("0", "unapprove")
  ];

  bool isMenu = false;

  void initViewModel({String? ModuleName, String? ToDoListType, bool? IsMenu}) {
    this.selectedStatus = '-1';
    print("initViewModel moduleName ${ModuleName}  ${ToDoListType}");
    if (!isEmpty(ModuleName) && !isEmpty(ToDoListType)) {
      clear();
      this.moduleName = ModuleName;
      this.toDoListType = ToDoListType.toString();
      getProjectAndTaskList();
    }
  }

  void initDetailViewModel(
      {String? C_Approval_Request_Id,
      String? ModuleName,
      String? ToDoListType}) {
    this.taskInfo = new TaskInfo();
    if (!isEmpty(ModuleName)) {
      this.moduleName = ModuleName;
      getProjectAndTaskListGetData(C_Approval_Request_Id, ModuleName);
    }
  }

  void initDetaiTaskViewModel(TaskInfo taskInfo) {
    this.taskInfo = new TaskInfo();
    if (!isEmpty(TaskInfo)) {
      this.taskInfo = taskInfo;
    }
  }

  void clear() {
    projectInfos.clear();
    this.taskInfo = new TaskInfo();
  }

  void initListener() {}

  void eventChangeStatus(String seStatus) async {
    this.selectedStatus = '-1';
    this.isMenu = true;
    if (seStatus != '-1') {
      this.selectedStatus = seStatus;
      getProjectAndTaskList();
    }
  }

  void getProjectAndTaskList() async {
    EasyLoading.show();

    if (this.isMenu) {
      ApiResponse json = await projectListApi.getProjectAndTaskListMenu(
          this.toDoListType,
          this.selectedStatus!,
          this.moduleName.toString(),
          this.isMenu);
      if (json.success) {
        if (!isEmpty(json.responseObject['Data'])) {
          projectResponse = BaseResponseApi<ProjectRequestModel>.fromJson(
              json.responseObject,
              compileData: (data) => !isEmpty(json.responseObject['Data'])
                  ? ProjectRequestModel.fromJson(json.responseObject['Data'])
                  : ProjectRequestModel());

          if (projectResponse!.isSuccess!) {
            ProjectRequestModel result = projectResponse!.data;
            if (!isEmpty(result) & !isEmpty(result.Data)) {
              projectInfos = result.Data!;
            }
            projectInfos = projectResponse!.data;
            print(projectResponse);
          } else {
            showAlertDialog(
                content: projectResponse?.errorMessage,
                context: NavigationService.navigatorKey.currentContext!,
                defaultActionText: "Đóng");
          }
        }
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    } else {
      ApiResponse json = await projectListApi.getProjectAndTaskList(
          this.toDoListType, this.moduleName.toString());
      if (json.success) {
        if (!isEmpty(json.responseObject['Data'])) {
          projectResponse = BaseResponseApi<List<ProjectInfo>>.fromJson(
              json.responseObject,
              compileData: (data) => !isEmpty(json.responseObject['Data'])
                  ? json.responseObject['Data']
                      ?.map((m) => ProjectInfo.fromJson(m))
                      .toList()
                      .cast<ProjectInfo>()
                  : ProjectInfo());

          if (projectResponse!.isSuccess!) {
            projectInfos = projectResponse!.data;
            print(projectResponse);
          } else {
            showAlertDialog(
                content: projectResponse?.errorMessage,
                context: NavigationService.navigatorKey.currentContext!,
                defaultActionText: "Đóng");
          }
        }

        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    }
  }

  void getProjectAndTaskListGetData(
      String? C_Approval_Request_Id, String? ModuleName) async {
    EasyLoading.show();
    this.projectDetailModel = new ProjectDetailModel();

    ApiResponse json = await projectListApi.getProjectAndTaskListGetData(
        C_Approval_Request_Id!, ModuleName!, toDoListType);
    if (json.success) {
      projectDetailResponse = BaseResponseApi<ProjectDetailModel>.fromJson(
          json.responseObject,
          compileData: (data) => !isEmpty(json.responseObject['Data'])
              ? ProjectDetailModel.fromJson(json.responseObject['Data'])
              : ProjectDetailModel());

      if (projectDetailResponse!.isSuccess!) {
        projectDetailModel = projectDetailResponse!.data;

        if (!isEmpty(projectDetailModel!.Tasks)) {
          var stt = 1;
          projectDetailModel!.Tasks?.forEach((e) {
            e.STT = stt;
            stt = stt + 1;
          });
        }

        print(projectResponse);
      }
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
    }
  }

  void approveOrRejectProjectAndTask(
      String moduleName,
      String approvalRequestId,
      bool isApprove,
      String notes,
      String ToDoListType) async {
    EasyLoading.show();
    ApiResponse json = await projectListApi.approveOrRejectProjectAndTask(
        moduleName, approvalRequestId, isApprove, notes, ToDoListType);
    if (json.success) {
      if (!isEmpty(json.responseObject['Data'])) {
        var result = BaseResponseApi<ApproveModel>.fromJson(json.responseObject,
            compileData: (data) => !isEmpty(json.responseObject['Data'])
                ? ApproveModel.fromJson(json.responseObject['Data'])
                : ApproveModel());
        var content =
            AppLocalizations.of(NavigationService.navigatorKey.currentContext!)!
                .translate('not_ok');
        if (result.isSuccess!) {
          var resultData = result.data;
          if (resultData.IsSuccess!) {
            content = AppLocalizations.of(
                    NavigationService.navigatorKey.currentContext!)!
                .translate('result_ok');
          } else {
            if (!isEmpty(resultData.ErroMessage)) {
              content = resultData.ErroMessage.toString();
            }
          }
        }
        showAlertDialog(
            content: content,
            context: NavigationService.navigatorKey.currentContext!,
            defaultActionText: "Đóng");
      }

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
    }
  }
}
