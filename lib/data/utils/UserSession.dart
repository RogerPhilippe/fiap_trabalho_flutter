class UserSession {

  static final UserSession _instance = UserSession._internal();
  static String userID;
  static String name;
  static String email;
  static String userToken;

  factory UserSession() {
    return _instance;
  }

  UserSession._internal();

}