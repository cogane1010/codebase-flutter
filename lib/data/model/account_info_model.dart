class AccountInfo {
  String? id;
  String? customerCode;
  String? firstName;
  String? lastName;
  String? fullName;
  String? lowerFullName;
  String? email;
  String? mobilePhone;
  String? dob;
  int? gender;
  bool? isMember;
  bool? isActive;
  String? userId;
  String? registerCourse;
  String? avatarFileId;
  String? imgUrl;
  String? imageData;
  String? password;
  String? confirmPassword;
  String? golfCardNo;
  String? otpId;
  String? otpCode;
  bool? isSendOtp;

  AccountInfo({
    this.id,
    this.customerCode,
    this.firstName,
    this.lastName,
    this.fullName,
    this.lowerFullName,
    this.email,
    this.mobilePhone,
    this.dob,
    this.gender,
    this.isMember,
    this.isActive,
    this.userId,
    this.registerCourse,
    this.avatarFileId,
    this.imgUrl,
    this.imageData,
    this.password,
    this.confirmPassword,
    this.golfCardNo,
    this.otpId,
    this.otpCode,
    this.isSendOtp,
  });

  AccountInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerCode = json['customerCode'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    lowerFullName = json['lowerFullName'];
    email = json['email'];
    mobilePhone = json['mobilePhone'];
    dob = json['dob'];
    gender = json['gender'];
    isMember = json['isMember'];
    isActive = json['isActive'];
    userId = json['userId'];
    registerCourse = json['registerCourse'];
    avatarFileId = json['avatarFileId'];
    imgUrl = json['img_Url'];
    imageData = json['imageData'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    golfCardNo = json['golf_CardNo'];
    otpId = json['otpId'];
    otpCode = json['otpCode'];
    isSendOtp = json['isSendOtp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerCode'] = this.customerCode;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['lowerFullName'] = this.lowerFullName;
    data['email'] = this.email;
    data['mobilePhone'] = this.mobilePhone;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['isMember'] = this.isMember;
    data['isActive'] = this.isActive;
    data['userId'] = this.userId;
    data['registerCourse'] = this.registerCourse;
    data['avatarFileId'] = this.avatarFileId;
    data['img_Url'] = this.imgUrl;
    data['imageData'] = this.imageData;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['golf_CardNo'] = this.golfCardNo;
    data['otpId'] = this.otpId;
    data['otpCode'] = this.otpCode;
    data['isSendOtp'] = this.isSendOtp;

    return data;
  }
}
