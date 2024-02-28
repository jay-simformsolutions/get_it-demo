class Photo {
  final String provider;
  final String terms;
  final String url;

  Photo(this.provider, this.terms, this.url);

  Photo.fromJson(Map<String, dynamic> json)
      : provider = json["provider"],
        terms = json["terms"],
        url = json["url"];
}