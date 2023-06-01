/// isUpdated : "true"
/// content : "fagsdf gsdfgdsfglse"

class TermAndCondition {
  TermAndCondition({
      this.isUpdated, 
      this.content,});

  TermAndCondition.fromJson(dynamic json) {
    isUpdated = json['isUpdated'];
    content = json['content'];
  }
  String? isUpdated;
  String? content;
TermAndCondition copyWith({  String? isUpdated,
  String? content,
}) => TermAndCondition(  isUpdated: isUpdated ?? this.isUpdated,
  content: content ?? this.content,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isUpdated'] = isUpdated;
    map['content'] = content;
    return map;
  }

}