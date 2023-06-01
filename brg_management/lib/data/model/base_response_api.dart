class BaseResponseApi<T> {
  bool? isSuccess;
  dynamic? statusCode;
  dynamic? errorMessage;
  T data;

  BaseResponseApi(
      {required this.data, this.isSuccess, this.statusCode, this.errorMessage});

  factory BaseResponseApi.fromJson(Map<String, dynamic> json,
      {required Function? compileData}) {
    return BaseResponseApi<T>(
        isSuccess: json['IsSuccess'] ?? "",
        statusCode: json['StatusCode'] ?? "",
        errorMessage: json['ErrorMessage'] ?? "",
        data: compileData!(json));
  }

  Map<String, dynamic> toJson() => {
        "IsSuccess": this.isSuccess,
        "StatusCode": this.statusCode,
        "ErrorMessage": this.errorMessage,
        "Data": this.data ?? [],
      };
}
