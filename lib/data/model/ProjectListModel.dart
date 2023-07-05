// ignore_for_file: non_constant_identifier_names

import 'package:brg_management/core/utils/isEmpty.dart';

class ProjectDetailModel {
  ProjectDetailModel({this.Project, this.Tasks, this.Request});

  ProjectDetailModel.fromJson(dynamic json) {
    if (json['Project'] != null) {
      Project = ProjectInfo.fromJson(json['Project']);
    }

    if (json['Tasks'] != null) {
      Tasks = <TaskInfo>[];
      json['Tasks'].forEach((v) {
        Tasks!.add(new TaskInfo.fromJson(v));
      });
    }

    if (json['Request'] != null) {
      Request = RequestInfo.fromJson(json['Request']);
    }
  }

  ProjectInfo? Project;
  List<TaskInfo>? Tasks;
  RequestInfo? Request;
}

class ProjectInfo {
  ProjectInfo({
    this.C_Project_Id,
    this.Code,
    this.Name,
    this.ProjectType,
    this.C_Approval_Request_Id,
    this.RequestType,
    this.RequestNote,
    this.RequestUser,
    this.FromStatus,
    this.lstOrgName,
    this.StatusName,
    this.Status,
    this.Note,
    this.CostAmt,
    this.Type,
    this.StartDate,
    this.Deadline,
  });

  ProjectInfo.fromJson(dynamic json) {
    C_Project_Id = json['C_Project_Id'];
    Code = !isEmpty(json['Code']) ? json['Code'] : json['ProjectCode'];
    Name = !isEmpty(json['Name']) ? json['Name'] : json['ProjectName'];
    ProjectType = json['ProjectType'];
    C_Approval_Request_Id = json['C_Approval_Request_Id'];
    RequestType = json['RequestType'];
    RequestNote = json['RequestNote'];
    RequestUser = json['RequestUser'];
    FromStatus = json['FromStatus'];
    lstOrgName = json['lstOrgName'];
    StatusName = json['StatusName'];
    Status = json['Status'];
    Note = json['Note'];
    CostAmt = json['CostAmt'];
    Type = json['Type'];
    StartDate =
        !isEmpty(json['StartDate']) ? DateTime.parse(json['StartDate']) : null;
    Deadline =
        !isEmpty(json['Deadline']) ? DateTime.parse(json['Deadline']) : null;
  }

  String? Type;
  String? C_Project_Id;
  String? Code;
  String? Name;
  String? ProjectType;
  String? C_Approval_Request_Id;
  String? RequestType;
  String? RequestNote;
  String? RequestUser;
  String? FromStatus;
  String? lstOrgName;
  String? StatusName;
  String? Status;
  String? Note;
  double? CostAmt;
  DateTime? StartDate;
  DateTime? Deadline;
}

class TaskDetailModel {
  TaskDetailModel({this.Request, this.Tasks});

  TaskDetailModel.fromJson(dynamic json) {
    if (json['Request'] != null) {
      Request = RequestInfo.fromJson(json['Request']);
    }

    if (json['Task'] != null) {
      Tasks = TaskInfo.fromJson(json['Task']);
    }
  }

  RequestInfo? Request;
  TaskInfo? Tasks;
}

class TaskInfo {
  TaskInfo(
      {this.STT,
      this.IsRequestApprovalTask,
      this.C_Task_Id,
      this.C_Project_Id,
      this.Code_Project,
      this.Name_Project,
      this.Code,
      this.Name,
      this.OldStartDate,
      this.OldDeadline,
      this.StartDate,
      this.Deadline,
      this.Actual_StartDate,
      this.Actual_EndDate,
      this.Status,
      this.Note,
      this.AssignedOrgName,
      this.AssignedUserName,
      this.TaskTypeName,
      this.ParentName,
      this.ResConfirmLoc,
      this.ResConfirmMethod,
      this.Density,
      this.Cost,
      this.PriorityName,
      this.StatusName,
      this.C_Approval_Request_Id,
      this.RequestUser,
      this.RequestType,
      this.RequestTypeName,
      this.OrgName,
      this.CreatedDate,
      this.CreatedUser,
      this.PercentComplete,
      this.AcceptStatusText,
      this.Progress});

  TaskInfo.fromJson(dynamic json) {
    STT = isEmpty(json['STT']) ? json['STT'] : null;
    IsRequestApprovalTask = isEmpty(json['IsRequestApprovalTask'])
        ? json['IsRequestApprovalTask']
        : null;
    C_Task_Id = !isEmpty(json['C_Task_Id']) ? json['C_Task_Id'] : "";
    C_Project_Id = !isEmpty(json['C_Project_Id']) ? json['C_Project_Id'] : "";
    Code_Project = !isEmpty(json['Code_Project'])
        ? json['Code_Project']
        : json['ProjectCode'];
    Name_Project = !isEmpty(json['Name_Project'])
        ? json['Name_Project']
        : json['ProjectName'];
    Code = !isEmpty(json['Code']) ? json['Code'] : json['TaskCode'];
    Name = !isEmpty(json['Name']) ? json['Name'] : json['TaskName'];
    OldStartDate = !isEmpty(json['OldStartDate'])
        ? DateTime.parse(json['OldStartDate'])
        : null;
    OldDeadline = !isEmpty(json['OldDeadline'])
        ? DateTime.parse(json['OldDeadline'])
        : null;
    StartDate =
        !isEmpty(json['StartDate']) ? DateTime.parse(json['StartDate']) : null;
    Deadline =
        !isEmpty(json['Deadline']) ? DateTime.parse(json['Deadline']) : null;
    Actual_StartDate = !isEmpty(json['Actual_StartDate'])
        ? DateTime.parse(json['Actual_StartDate'])
        : null;
    Actual_EndDate = !isEmpty(json['Actual_EndDate'])
        ? DateTime.parse(json['Actual_EndDate'])
        : null;
    Status = !isEmpty(json['Status']) ? json['Status'] : "";
    Note = !isEmpty(json['Note']) ? json['Note'] : "";
    AssignedOrgName =
        !isEmpty(json['AssignedOrgName']) ? json['AssignedOrgName'] : "";
    AssignedUserName =
        !isEmpty(json['AssignedUserName']) ? json['AssignedUserName'] : "";
    TaskTypeName = !isEmpty(json['TaskTypeName']) ? json['TaskTypeName'] : "";
    ParentName = !isEmpty(json['ParentName']) ? json['ParentName'] : "";
    ResConfirmLoc =
        !isEmpty(json['ResConfirmLoc']) ? json['ResConfirmLoc'] : "";
    ResConfirmMethod =
        !isEmpty(json['ResConfirmMethod']) ? json['ResConfirmMethod'] : "";
    Density = !isEmpty(json['Density']) ? json['Density'] : null;
    Cost = !isEmpty(json['Cost']) ? json['Cost'] : null;
    PriorityName = !isEmpty(json['PriorityName']) ? json['PriorityName'] : "";
    StatusName = !isEmpty(json['StatusName']) ? json['StatusName'] : "";
    C_Approval_Request_Id = !isEmpty(json['C_Approval_Request_Id'])
        ? json['C_Approval_Request_Id']
        : "";
    RequestUser = !isEmpty(json['RequestUser']) ? json['RequestUser'] : "";
    RequestType = !isEmpty(json['RequestType']) ? json['RequestType'] : "";
    RequestTypeName =
        !isEmpty(json['RequestTypeName']) ? json['RequestTypeName'] : "";
    OrgName = !isEmpty(json['OrgName']) ? json['OrgName'] : "";
    CreatedDate = !isEmpty(json['CreatedDate']) ? json['CreatedDate'] : "";
    CreatedUser = !isEmpty(json['CreatedUser']) ? json['CreatedUser'] : "";
    PercentComplete =
        !isEmpty(json['PercentComplete']) ? json['PercentComplete'] : null;
    AcceptStatusText =
        !isEmpty(json['AcceptStatusText']) ? json['AcceptStatusText'] : "";

    if (json['ProgressHistory'] != null) {
      Progress = <TaskProgress>[];
      json['ProgressHistory'].forEach((v) {
        Progress!.add(new TaskProgress.fromJson(v));
      });
    }
  }

  int? STT;
  bool? IsRequestApprovalTask;
  String? C_Task_Id;
  String? C_Project_Id;
  String? Code_Project;
  String? Name_Project;
  String? Code;
  String? Name;
  DateTime? OldStartDate;
  DateTime? OldDeadline;
  DateTime? StartDate;
  DateTime? Deadline;
  DateTime? Actual_StartDate;
  DateTime? Actual_EndDate;
  String? Status;
  String? Note;
  String? AssignedOrgName;
  String? AssignedUserName;
  String? TaskTypeName;
  String? ParentName;
  String? ResConfirmLoc;
  String? ResConfirmMethod;
  double? Density;
  double? Cost;
  String? PriorityName;
  String? StatusName;
  String? C_Approval_Request_Id;
  String? RequestUser;
  String? RequestType;
  String? RequestTypeName;
  String? OrgName;
  String? CreatedDate;
  String? CreatedUser;
  double? PercentComplete;
  String? AcceptStatusText;

  List<TaskProgress>? Progress;
}

class RequestInfo {
  RequestInfo({this.C_Approval_Request_Id, this.RequestType});

  RequestInfo.fromJson(dynamic json) {
    C_Approval_Request_Id = json['C_Approval_Request_Id'];
    RequestType = json['RequestType'];
  }
  String? C_Approval_Request_Id;
  String? RequestType;
}

class TaskProgress {
  TaskProgress(
      {this.C_Task_Id,
      this.C_Project_Id,
      this.NewComplPercent,
      this.Status,
      this.StatusName,
      this.ToDate});

  TaskProgress.fromJson(dynamic json) {
    C_Task_Id = json['C_Approval_Request_Id'];
    C_Project_Id = json['C_Project_Id'];
    NewComplPercent = json['NewComplPercent'];
    Status = json['Status'];
    StatusName = json['StatusName'];
    ToDate = !isEmpty(json['ToDate']) ? DateTime.parse(json['ToDate']) : null;
  }

  String? C_Task_Id;
  String? C_Project_Id;
  double? NewComplPercent;
  String? Status;
  String? StatusName;
  DateTime? ToDate;
}

class ApproveModel {
  ApproveModel({this.IsSuccess, this.ErroMessage});

  ApproveModel.fromJson(dynamic json) {
    IsSuccess = json['IsSuccess'];
    ErroMessage = json['ErroMessage'];
  }

  bool? IsSuccess;
  String? ErroMessage;
}

class TaskProgressRequestModel {
  TaskProgressRequestModel({this.TotalCount, this.Data});

  TaskProgressRequestModel.fromJson(dynamic json) {
    TotalCount = json['TotalCount'];

    if (json['Data'] != null) {
      Data = <TaskInfo>[];
      json['Data'].forEach((v) {
        Data!.add(new TaskInfo.fromJson(v));
      });
    }
  }

  int? TotalCount;
  List<TaskInfo>? Data;
}

class ProjectRequestModel {
  ProjectRequestModel({this.TotalCount, this.Data});

  ProjectRequestModel.fromJson(dynamic json) {
    TotalCount = json['TotalCount'];

    if (json['Data'] != null) {
      Data = <ProjectInfo>[];
      json['Data'].forEach((v) {
        Data!.add(new ProjectInfo.fromJson(v));
      });
    }
  }

  int? TotalCount;
  List<ProjectInfo>? Data;
}

class StatusModel {
  StatusModel(this.ValueStatus, this.NameStatus);

  String? ValueStatus;
  String? NameStatus;
}

class AdjustProjectModel {
  AdjustProjectModel({this.Request, this.Project, this.Tasks});

  AdjustProjectModel.fromJson(dynamic json) {
    if (json['Request'] != null) {
      Request = RequestInfo.fromJson(json['Request']);
    }

    // if (json['Task'] != null) {
    //   Tasks = TaskInfo.fromJson(json['Task']);
    // }

    if (json['lstTaskDeadlineAdjust'] != null) {
      Tasks = <TaskInfo>[];
      json['lstTaskDeadlineAdjust'].forEach((v) {
        Tasks!.add(new TaskInfo.fromJson(v));
      });
    }

    if (json['project'] != null) {
      Project = ProjectInfo.fromJson(json['project']);
    }
  }

  RequestInfo? Request;
  List<TaskInfo>? Tasks;
  //TaskInfo? Tasks;
  ProjectInfo? Project;
}
