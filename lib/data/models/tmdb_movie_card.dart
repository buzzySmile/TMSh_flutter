class TMDbMovieCard extends Object {
  static const String imageBaseUrl = 'http://image.tmdb.org/t/p/w185/';

  final int id;
  final voteAverage;
  final String title;
  final String posterPath;
  final String overview;

  String get poster => posterPath == null ? '' : imageBaseUrl + this.posterPath;

  TMDbMovieCard(
      this.id, this.title, this.overview, this.voteAverage, this.posterPath);

  TMDbMovieCard.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        overview = json['overview'],
        voteAverage = json['vote_average'],
        posterPath = json['poster_path'] == null ? '' : json['poster_path'];

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'overview': this.overview,
      'vote_average': this.voteAverage,
      'poster_path': this.posterPath,
    };
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || this.id == other.id;

  @override
  int get hashCode => id;

  @override
  String toString() {
    return "$id-$title";
  }
}
