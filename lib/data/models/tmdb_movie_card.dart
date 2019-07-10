class TMDbMovieCard extends Object {
  static const String imageBaseUrl = 'http://image.tmdb.org/t/p/w185/';

  final int id;
  final voteAverage;
  final String title;
  final String posterPath;
  final String overview;

  TMDbMovieCard(
      this.id, this.title, this.overview, this.voteAverage, this.posterPath);

  TMDbMovieCard.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        overview = json['overview'],
        voteAverage = json['vote_average'],
        posterPath = json['poster_path'] == null
            ? ''
            : imageBaseUrl + json['poster_path'];

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || this.id == other.id;

  @override
  int get hashCode => id;
}
