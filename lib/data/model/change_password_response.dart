
class ChangePasswordResponse {
  ChangePasswordResponse({
    this.data,
  });
  String? data;

  ChangePasswordResponse.fromJson(Map<String, dynamic>? json) {
    data = json?['data'];
  }
}
