/// messageVn : true
/// messageVnVersion : "1.0"
/// messageEn : true
/// messageEnVersion : "1.0"
/// termsConditionsVn : true
/// termsConditionsVnVersion : null
/// termsConditionsEn : true
/// termsConditionsEnVersion : null
/// cancelPolicyVn : true
/// cancelPolicyVnVersion : null
/// cancelPolicyEn : true
/// cancelPolicyEnVersion : null

class CheckUpdateMessage {
  CheckUpdateMessage({
      this.messageVn, 
      this.messageVnVersion, 
      this.messageEn, 
      this.messageEnVersion, 
      this.termsConditionsVn, 
      this.termsConditionsVnVersion, 
      this.termsConditionsEn, 
      this.termsConditionsEnVersion, 
      this.cancelPolicyVn, 
      this.cancelPolicyVnVersion, 
      this.cancelPolicyEn, 
      this.cancelPolicyEnVersion,});

  CheckUpdateMessage.fromJson(dynamic json) {
    messageVn = json['messageVn'];
    messageVnVersion = json['messageVnVersion'];
    messageEn = json['messageEn'];
    messageEnVersion = json['messageEnVersion'];
    termsConditionsVn = json['termsConditionsVn'];
    termsConditionsVnVersion = json['termsConditionsVnVersion'];
    termsConditionsEn = json['termsConditionsEn'];
    termsConditionsEnVersion = json['termsConditionsEnVersion'];
    cancelPolicyVn = json['cancelPolicyVn'];
    cancelPolicyVnVersion = json['cancelPolicyVnVersion'];
    cancelPolicyEn = json['cancelPolicyEn'];
    cancelPolicyEnVersion = json['cancelPolicyEnVersion'];
  }
  bool? messageVn;
  String? messageVnVersion;
  bool? messageEn;
  String? messageEnVersion;
  bool? termsConditionsVn;
  dynamic termsConditionsVnVersion;
  bool? termsConditionsEn;
  dynamic termsConditionsEnVersion;
  bool? cancelPolicyVn;
  dynamic cancelPolicyVnVersion;
  bool? cancelPolicyEn;
  dynamic cancelPolicyEnVersion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageVn'] = messageVn;
    map['messageVnVersion'] = messageVnVersion;
    map['messageEn'] = messageEn;
    map['messageEnVersion'] = messageEnVersion;
    map['termsConditionsVn'] = termsConditionsVn;
    map['termsConditionsVnVersion'] = termsConditionsVnVersion;
    map['termsConditionsEn'] = termsConditionsEn;
    map['termsConditionsEnVersion'] = termsConditionsEnVersion;
    map['cancelPolicyVn'] = cancelPolicyVn;
    map['cancelPolicyVnVersion'] = cancelPolicyVnVersion;
    map['cancelPolicyEn'] = cancelPolicyEn;
    map['cancelPolicyEnVersion'] = cancelPolicyEnVersion;
    return map;
  }

}