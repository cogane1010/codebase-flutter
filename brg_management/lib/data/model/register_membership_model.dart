/// customerCode : "GA22000005"
/// firstName : null
/// lastName : null
/// fullName : "sdfsdf"
/// lowerFullName : "sdfsdf"
/// email : "admin111@gmail.com"
/// mobilePhone : "43534543"
/// dob : "2022-06-23T00:00:00"
/// gender : 0
/// isMember : false
/// isActive : true
/// userId : "fb7e10b2-05d5-40e5-a86c-325facec5b46"
/// fcmTokenDevice : null
/// avatarFileId : "e30bcc2f-7105-4a85-aa81-fa7ed49eba7b"
/// img_Url : "Assets\\Avatar\\14-01-2022-16-04-04-365.jpg"
/// memberCards : null
/// golf_CardNo : null
/// id : "2aef614b-a472-4f0f-8c1b-5c92a9e02439"

class RegisterMembershipModel {
  RegisterMembershipModel({
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
    this.fcmTokenDevice,
    this.avatarFileId,
    this.imgUrl,
    this.id,
  });

  RegisterMembershipModel.fromJson(dynamic json) {
    customerCode = json?['customerCode'];
    firstName = json?['firstName'];
    lastName = json?['lastName'];
    fullName = json?['fullName'];
    lowerFullName = json?['lowerFullName'];
    email = json?['email'];
    mobilePhone = json?['mobilePhone'];
    dob = json?['dob'];
    gender = json?['gender'];
    isMember = json?['isMember'];
    isActive = json?['isActive'];
    userId = json?['userId'];
    fcmTokenDevice = json?['fcmTokenDevice'];
    avatarFileId = json?['avatarFileId'];
    imgUrl = json?['img_Url'];
    id = json?['id'];
  }
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
  String? userId;
  dynamic fcmTokenDevice;
  String? avatarFileId;
  String? imgUrl;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['userId'] = userId;
    map['fcmTokenDevice'] = fcmTokenDevice;
    map['avatarFileId'] = avatarFileId;
    map['img_Url'] = imgUrl;
    map['id'] = id;
    return map;
  }
}
