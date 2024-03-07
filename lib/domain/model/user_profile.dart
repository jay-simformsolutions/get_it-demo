class UserProfile {
  UserProfile({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.website,
  });

  final int id;
  final String name;
  final String username;
  final String email;
  final String website;

  UserProfile.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        username = json["username"],
        email = json["email"],
        website = json["website"];
}
