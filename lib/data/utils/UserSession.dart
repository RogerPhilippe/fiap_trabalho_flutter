class UserSession {

  static final UserSession _instance = UserSession._internal();
  static String name;
  static String email;

  factory UserSession() {
    return _instance;
  }

  UserSession._internal();

}