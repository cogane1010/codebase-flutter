import 'dart:convert';

import 'package:brg_management/configs/base_api.dart';
import 'package:brg_management/data/local/user_session.dart';
import 'package:brg_management/data/model/response.dart';

class ProjectListApi extends BaseApi {
  Future<ApiResponse> getProjectAndTaskList(
      String toDoListType, String moduleName) async {
    var request =
        jsonEncode({"ToDoListType": toDoListType, "ModuleName": moduleName});

    var urlData = getFullPath('/api/app/TodoList/ProjectAndTaskList');
    if (toDoListType == 'ListProcessingApproval') {
      urlData = getFullPath('/api/app/TodoList/ListProcessingApproval');
    }
    if (toDoListType == 'ListProgressApproval') {
      urlData = getFullPath('/api/app/TodoList/ListProgressApproval');
    }

    var response = await httpRequest.sendPost(
      requestBody: request,
      token: "Bearer ${UserSession.instance.token}",
      contentType: "application/json",
      uri: urlData,
    );
    return validateResponse(response);
  }

  Future<ApiResponse> getProjectAndTaskListMenu(String toDoListType,
      String selectedStatus, String moduleName, bool isMenu) async {
    var request = jsonEncode({
      "pageIndex": 0,
      "pageSize": 1000,
      "AcceptStatus": selectedStatus,
      "ModuleName": moduleName
    });

    var urlData = getFullPath('/api/app/approvalRequestList/getProjectRequest');
    if (toDoListType == 'ListProcessingApproval') {
      urlData = getFullPath('/api/app/approvalRequestList/getTaskRequest');
    }
    if (toDoListType == 'ListProgressApproval') {
      urlData =
          getFullPath('/api/app/approvalRequestList/getTaskProgressRequest');
    }

    var response = await httpRequest.sendPost(
      requestBody: request,
      token: "Bearer ${UserSession.instance.token}",
      contentType: "application/json",
      uri: urlData,
    );
    return validateResponse(response);
  }

  Future<ApiResponse> getProjectAndTaskListGetData(String C_Approval_Request_Id,
      String ModuleName, String toDoListType) async {
    var request = jsonEncode({
      "C_Approval_Request_Id": C_Approval_Request_Id,
      "ModuleName": ModuleName
    });
    var urlData = getFullPath('/api/app/TodoList/ProjectAndTaskListGetData');
    if (toDoListType == 'ProjectPending' ||
        toDoListType == 'ListProcessingApproval') {
      urlData = getFullPath('/api/app/TodoList/ProjectAndTaskListGetData');
    }
    if (toDoListType == 'ListProgressApproval') {
      urlData = getFullPath('/api/app/TodoList/ProgressApprovalGetData');
    }
    var response = await httpRequest.sendPost(
      requestBody: request,
      token: "Bearer ${UserSession.instance.token}",
      contentType: "application/json",
      uri: urlData,
    );

    return validateResponse(response);
  }

  Future<ApiResponse> approveOrRejectProjectAndTask(
      String ModuleName,
      String C_Approval_Request_Id,
      bool IsApprove,
      String ResponseNote,
      String TodoListType) async {
    var request = jsonEncode({
      "ModuleName": ModuleName,
      "C_Approval_Request_Id": C_Approval_Request_Id,
      "IsApprove": IsApprove,
      "ResponseNote": ResponseNote
    });
    var urlData =
        getFullPath('/api/app/TodoList/approveOrRejectProjectAndTask');
    if (TodoListType == 'ListProgressApproval') {
      urlData = getFullPath('/api/app/TodoList/approveOrRejectTaskProgress');
    }
    var response = await httpRequest.sendPost(
      requestBody: request,
      token: "Bearer ${UserSession.instance.token}",
      contentType: "application/json",
      uri: urlData,
    );
    return validateResponse(response);
  }

  Future<ApiResponse> getListProcessingApproval(
      String toDoListType, String moduleName) async {
    var request =
        jsonEncode({"ToDoListType": toDoListType, "ModuleName": moduleName});

    var urlData = getFullPath('/api/app/TodoList/ListProcessingApproval');
    if (toDoListType == 'ListProgressApproval') {
      urlData = getFullPath('/api/app/TodoList/ListProgressApproval');
    }

    var response = await httpRequest.sendPost(
      requestBody: request,
      token: "Bearer ${UserSession.instance.token}",
      contentType: "application/json",
      uri: urlData,
    );
    return validateResponse(response);
  }
}
