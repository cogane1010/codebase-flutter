class CustomerCode {
  CustomerCode({
    dynamic errorCode,
    String? golfCusGroupCode,
    String? bKCusGroupCode,
    dynamic usedInCourse,
  }) {
    _errorCode = errorCode;
    _golfCusGroupCode = golfCusGroupCode;
    _bKCusGroupCode = bKCusGroupCode;
    _usedInCourse = usedInCourse;
  }
  dynamic _errorCode;
  String? _golfCusGroupCode;
  String? _bKCusGroupCode;
  dynamic _usedInCourse;

  dynamic get errorCode => _errorCode;
  String? get golfCusGroupCode => _golfCusGroupCode;
  String? get bKCusGroupCode => _bKCusGroupCode;
  dynamic get usedInCourse => _usedInCourse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errorCode'] = _errorCode;
    map['golf_CusGroupCode'] = _golfCusGroupCode;
    map['bK_CusGroupCode'] = _bKCusGroupCode;
    map['usedInCourse'] = _usedInCourse;
    return map;
  }
}
