class Post{

  Post(this.body, this.title);

  final String body;
  final String title;

  Post.fromJson(Map<String, dynamic> json)
      : body = json["body"],
        title = json["title"];
}