// ignore_for_file: file_names

class Movies {
  String? title;
  String? genre;
  String? poster;
  String? imdbRating;

  Movies({
    this.title,
    this.genre,
    this.poster,
    this.imdbRating,
  });

  Movies.fromJson(Map<String, dynamic> json) {
    title = json['Title'].toString();
    genre = json['Genre'].toString();
    poster = json['Poster'].toString();
    imdbRating = json['imdbRating'].toString();
  }
}
