import 'package:brg_management/core/utils/app_color.dart';
import 'package:brg_management/data/repositories/home_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/utils/convertor.dart';
import '../../../core/utils/isEmpty.dart';
import '../../../data/model/TodoModel.dart';
import '../../../data/model/base_response_api.dart';
import '../../../data/model/home_data.dart';
import '../../../data/model/response.dart';

class TodoListViewModel extends ChangeNotifier {
  HomeApi homeApi = HomeApi();
  BaseResponseApi? homeResponse;
  HomeData? homeData;
  String? moduleId;
  late String moduleName;
  int waitingAprroval = 0;
  List<TodoModel> todoModel = [];
  BaseResponseApi? todoResponse;

  TodoModel? projectPending;
  TodoModel? taskProcessing;
  TodoModel? taskProcessingApproval;
  TodoModel? taskProgressApproval;

  Color projectPendingheaderBorder = AppColor.grey2;
  Color taskProcessingheaderBorder = AppColor.grey2;
  Color taskProcessingApprovalheaderBorder = AppColor.grey2;
  Color taskProgressApprovalheaderBorder = AppColor.grey2;

  void initViewModel(String moduleName) {
    print("moduleId todolist ${moduleName}");

    if (!isEmpty(moduleName)) {
      this.moduleName = moduleName;
      getTodoListData();
    }
  }

  void getTodoListData() async {
    EasyLoading.show();

    ApiResponse json = await homeApi.getCountTodoList(this.moduleName);
    if (json.success) {
      todoResponse = BaseResponseApi<List<TodoModel>>.fromJson(
          json.responseObject,
          compileData: (data) => !isEmpty(json.responseObject['Data'])
              ? json.responseObject['Data']
                  .map((m) => TodoModel.fromJson(m))
                  .toList()
                  .cast<TodoModel>()
              : TodoModel());

      if (todoResponse!.isSuccess!) {
        todoModel = todoResponse!.data;
        if (todoModel.isNotEmpty) {
          this.projectPending =
              todoModel.firstWhere((i) => i.toDoListType == 'ProjectPending');
          projectPendingheaderBorder =
              Convertors.hexToColor(this.projectPending!.color.toString());
          this.taskProcessing =
              todoModel.firstWhere((i) => i.toDoListType == 'Task_Processing');
          taskProcessingheaderBorder =
              Convertors.hexToColor(this.taskProcessing!.color.toString());
          this.taskProcessingApproval = todoModel
              .firstWhere((i) => i.toDoListType == 'Task_ProcessingApproval');
          taskProcessingApprovalheaderBorder = Convertors.hexToColor(
              this.taskProcessingApproval!.color.toString());
          this.taskProgressApproval = todoModel
              .firstWhere((i) => i.toDoListType == 'Task_ProgressApproval');
          taskProgressApprovalheaderBorder = Convertors.hexToColor(
              this.taskProgressApproval!.color.toString());
        }

        print(todoModel);
        notifyListeners();
      }

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
    }
  }
}
