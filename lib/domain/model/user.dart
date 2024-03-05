class User {
  User({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  User.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"];
}
