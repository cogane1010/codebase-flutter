class ApiResponse {
  ApiResponse(
      {this.success = true,
        this.fromSpecialError = false,
      this.statusCode = 0,
      this.responseBody = '',
      this.responseObject,
      this.responseHeader,
      this.responseBodyByte});

  int statusCode;
  bool success;
  bool fromSpecialError;
  var responseBody;
  var responseObject;
  var responseHeader;
  var responseBodyByte;
}
