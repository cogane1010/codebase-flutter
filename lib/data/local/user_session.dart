class UserSession {
  static final UserSession _singleton = UserSession._internal();
  static UserSession get instance => _singleton;
  bool isConnectSdk = false;
  String usn = '';
  String pw = '';
  String fullName = '';
  String orgName = '';
  String email = '';
  String userName = '';
  String selectedModule = '';

  factory UserSession() {
    return _singleton;
  }

  UserSession._internal();

  String token = '';
  String currentLanguage = "vi";
  Map<dynamic, dynamic> enMessages = {};
  Map<dynamic, dynamic> vnMessages = {};
  var lockTime = 600000;
}
