class HomeData {
  HomeData(this.moduleData);

  List<ModuleData> moduleData = [];

  HomeData.fromJson(dynamic json) {
    if (json != null) {
      json.forEach((v) {
        moduleData.add(ModuleData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Data'] = moduleData.map((v) => v.toJson()).toList();

    return map;
  }
}

class ModuleData {
  ModuleData({this.moduleId, this.tittle, this.moduleName, this.icon});

  ModuleData.fromJson(dynamic json) {
    moduleId = json['ModuleId'];
    tittle = json['Tittle'];
    moduleName = json['ModuleName'];
    icon = json['Icon'];
  }
  String? moduleId;
  String? tittle;
  String? moduleName;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ModuleId'] = moduleId;
    map['Tittle'] = tittle;
    map['ModuleName'] = moduleName;
    map['Icon'] = icon;

    return map;
  }
}

class Customer {
  Customer({
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
    this.createdUser,
    this.createdDate,
    this.updatedUser,
    this.updatedDate,
    this.userId,
    this.avatarFileId,
    this.imgUrl,
    this.imageData,
    this.password,
    this.confirmPassword,
  });

  Customer.fromJson(dynamic json) {
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
    createdUser = json['createdUser'];
    createdDate = json['createdDate'];
    updatedUser = json['updatedUser'];
    updatedDate = json['updatedDate'];
    userId = json['userId'];
    avatarFileId = json['avatarFileId'];
    imgUrl = json['img_Url'];
    imageData = json['imageData'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];

    // if (json['memberCards'] != null) {
    //   memberCards = [];
    //   json['memberCards'].forEach((v) {
    //     memberCards?.add(dynamic.fromJson(v));
    //   });
    // }
  }
  String? id;
  String? customerCode;
  dynamic firstName;
  dynamic lastName;
  String? fullName;
  String? lowerFullName;
  String? email;
  String? mobilePhone;
  String? dob;
  int? gender;
  bool? isMember;
  bool? isActive;
  String? createdUser;
  String? createdDate;
  String? updatedUser;
  String? updatedDate;
  String? userId;
  String? avatarFileId;
  String? imgUrl;
  dynamic imageData;
  dynamic password;
  dynamic confirmPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customerCode'] = customerCode;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['fullName'] = fullName;
    map['lowerFullName'] = lowerFullName;
    map['email'] = email;
    map['mobilePhone'] = mobilePhone;
    map['dob'] = dob;
    map['gender'] = gender;
    map['isMember'] = isMember;
    map['isActive'] = isActive;
    map['createdUser'] = createdUser;
    map['createdDate'] = createdDate;
    map['updatedUser'] = updatedUser;
    map['updatedDate'] = updatedDate;
    map['userId'] = userId;
    map['avatarFileId'] = avatarFileId;
    map['img_Url'] = imgUrl;
    map['imageData'] = imageData;
    map['password'] = password;
    map['confirmPassword'] = confirmPassword;

    return map;
  }
}
