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

class TaskListViewModel extends ChangeNotifier {
  ProjectListApi projectListApi = ProjectListApi();
  ProjectDetailModel? projectDetailModel;
  String toDoListType = 'ProjectPending';
  String? moduleName;
  bool isMenu = false;
  int statudCode = 1;
  String? selectedStatus = '-1';
  BaseResponseApi? taskResponse;
  BaseResponseApi? taskDetailResponse;
  String titleBar = "";
  List<TaskInfo> taskInfos = [];
  TaskDetailModel taskDetailModel = new TaskDetailModel();
  Color headerBorder = Convertors.hexToColor('#9f0010');
  List<StatusModel> statuses = [
    new StatusModel("-1", "all"),
    new StatusModel("2", "waiting"),
    new StatusModel("1", "approve"),
    new StatusModel("0", "unapprove")
  ];

  void initViewModel({String? ModuleName, String? ToDoListType, bool? IsMenu}) {
    this.selectedStatus = '-1';
    print("initViewModel moduleName ${ModuleName}  ${ToDoListType}");
    if (!isEmpty(ModuleName) && !isEmpty(ToDoListType)) {
      clear();
      this.moduleName = ModuleName;
      this.toDoListType = ToDoListType.toString();
      if (!isEmpty(IsMenu)) {
        this.isMenu = IsMenu!;
      } else {
        this.isMenu = false;
      }
      getListProcessingApproval();
    }
  }

  void initDetailViewModel(
      {String? C_Approval_Request_Id,
      String? ModuleName,
      String? ToDoListType}) {
    this.taskDetailModel = new TaskDetailModel();
    if (!isEmpty(ModuleName)) {
      this.moduleName = ModuleName;
      getProgressApprovalGetData(
          C_Approval_Request_Id, ModuleName, ToDoListType);
    }
  }

  void initDetailProjectViewModel(
      {String? C_Approval_Request_Id,
      String? ModuleName,
      String? ToDoListType}) {
    this.taskDetailModel = new TaskDetailModel();
    if (!isEmpty(ModuleName)) {
      this.moduleName = ModuleName;
      getProgressingApprovalData(
          C_Approval_Request_Id, ModuleName, ToDoListType);
    }
  }

  void clear() {
    this.taskDetailModel = new TaskDetailModel();
  }

  void initListener() {}

  void eventChangeStatus(String seStatus) async {
    this.selectedStatus = '-1';
    this.isMenu = true;
    if (seStatus != '-1') {
      this.selectedStatus = seStatus;
      getListProcessingApproval();
    }
    notifyListeners();
  }

  void getListProcessingApproval() async {
    EasyLoading.show();
    ApiResponse json;
    if (this.isMenu) {
      json = await projectListApi.getProjectAndTaskListMenu(this.toDoListType,
          this.selectedStatus!, this.moduleName.toString(), this.isMenu);
      if (json.success) {
        if (!isEmpty(json.responseObject['Data'])) {
          taskResponse = BaseResponseApi<TaskProgressRequestModel>.fromJson(
              json.responseObject,
              compileData: (data) => !isEmpty(json.responseObject['Data'])
                  ? TaskProgressRequestModel.fromJson(
                      json.responseObject['Data'])
                  : TaskProgressRequestModel());

          if (taskResponse!.isSuccess!) {
            TaskProgressRequestModel result = taskResponse!.data;
            if (!isEmpty(result) & !isEmpty(result.Data)) {
              taskInfos = result.Data!;
            }

            print(taskInfos);
            notifyListeners();
          }
        }
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    } else {
      json = await projectListApi.getProjectAndTaskList(
          this.toDoListType, this.moduleName.toString());
      if (json.success) {
        if (!isEmpty(json.responseObject['Data'])) {
          taskResponse = BaseResponseApi<List<TaskInfo>>.fromJson(
              json.responseObject,
              compileData: (data) => !isEmpty(json.responseObject['Data'])
                  ? json.responseObject['Data']
                      ?.map((m) => TaskInfo.fromJson(m))
                      .toList()
                      .cast<TaskInfo>()
                  : TaskInfo());

          if (taskResponse!.isSuccess!) {
            taskInfos = taskResponse!.data;
            print(taskInfos);
            notifyListeners();
          }
        }

        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    }
  }

  void getProgressApprovalGetData(String? C_Approval_Request_Id,
      String? ModuleName, String? TodoListType) async {
    EasyLoading.show();

    ApiResponse json = await projectListApi.getProjectAndTaskListGetData(
        C_Approval_Request_Id!, ModuleName!, TodoListType!);
    if (json.success) {
      taskDetailResponse = BaseResponseApi<TaskDetailModel>.fromJson(
          json.responseObject,
          compileData: (data) => !isEmpty(json.responseObject['Data'])
              ? TaskDetailModel.fromJson(json.responseObject['Data'])
              : TaskDetailModel());

      if (taskDetailResponse!.isSuccess!) {
        taskDetailModel = taskDetailResponse!.data;
        notifyListeners();
      } else {
        showAlertDialog(
            content: taskDetailResponse?.errorMessage,
            context: NavigationService.navigatorKey.currentContext!,
            defaultActionText: "Đóng");
      }
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
    }
  }

  void getProgressingApprovalData(String? C_Approval_Request_Id,
      String? ModuleName, String? TodoListType) async {
    EasyLoading.show();

    ApiResponse json = await projectListApi.getProjectAndTaskListGetData(
        C_Approval_Request_Id!, ModuleName!, TodoListType!);
    if (json.success) {
      taskDetailResponse = BaseResponseApi<ProjectDetailModel>.fromJson(
          json.responseObject,
          compileData: (data) => !isEmpty(json.responseObject['Data'])
              ? ProjectDetailModel.fromJson(json.responseObject['Data'])
              : ProjectDetailModel());

      if (taskDetailResponse!.isSuccess!) {
        projectDetailModel = taskDetailResponse!.data;

        if (!isEmpty(projectDetailModel!.Tasks)) {
          var stt = 1;
          projectDetailModel!.Tasks?.forEach((e) {
            e.STT = stt;
            stt = stt + 1;
          });
        }

        notifyListeners();
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
      String TodoListType) async {
    EasyLoading.show();
    ApiResponse json = await projectListApi.approveOrRejectProjectAndTask(
        moduleName, approvalRequestId, isApprove, notes, TodoListType);
    if (json.success) {
      var aaaa = json.responseObject['Data'];
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
        notifyListeners();
      }

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
    }
  }
}
