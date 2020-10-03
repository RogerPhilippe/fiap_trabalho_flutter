class UserSession {

  String userID;
  String name;
  String email;
  String userToken;

  void clearUser() {
    userID = "";
    name = "";
    email = "";
    userToken = "";
  }

}