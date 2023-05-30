class UpdateUserResponse  {
  UpdateUserResponse({
    this.data,
  });

  String? data;


  UpdateUserResponse.fromJson(Map<String, dynamic>? json) {
    data = json?['data'] ?? "";
  }
}