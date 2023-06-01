class DataLogin {
  DataLogin(
      {this.status,
      this.extendCode,
      this.token,
      this.refreshToken,
      this.userInfo});

  DataLogin.fromJson(dynamic json) {
    status = json['Status'] ?? "";
    extendCode = json['ExtendCode'] ?? "";
    token = json['Token'] ?? "";
    refreshToken = json['RefreshToken'] ?? "";

    if (json['UserInfo'] != null) {
      userInfo = UserInfo.fromJson(json['UserInfo']);
    }
  }

  int? status;
  int? extendCode;
  String? token;
  String? refreshToken;
  UserInfo? userInfo;
}

class UserInfo {
  UserInfo({this.fullName, this.orgName, this.email, this.userName});

  UserInfo.fromJson(dynamic json) {
    fullName = json['FullName'] ?? "";
    orgName = json['OrgName'] ?? "";
    email = json['Email'] ?? "";
    userName = json['UserName'] ?? "";
  }
  String? fullName;
  String? orgName;
  String? email;
  String? userName;
}
