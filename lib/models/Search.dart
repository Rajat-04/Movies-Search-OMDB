class Search {
  String? title;

  Search({this.title});

  Search.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
  }
}
