// ignore_for_file: file_names

class Movies {
  String? title;
  String? genre;
  String? poster;
  String? imdbRating;
  String? plot;

  Movies({
    this.title,
    this.genre,
    this.poster,
    this.imdbRating,
    this.plot,
  });

  Movies.fromJson(Map<String, dynamic> json) {
    title = json['Title'].toString();
    genre = json['Genre'].toString();
    poster = json['Poster'].toString();
    imdbRating = json['imdbRating'].toString();
    plot = json['Plot'].toString();
  }
}
