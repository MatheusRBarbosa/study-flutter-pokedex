class Index {
  final String name;
  final String url;

  Index({this.name, this.url});

  factory Index.fromJson(Map<String, dynamic> json) {
    return Index(name: json['name'], url: json['url']);
  }
}
