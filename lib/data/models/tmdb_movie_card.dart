class TMDbMovieCard {
  static const String imageBaseUrl = 'http://image.tmdb.org/t/p/w185/';

  final int? id;
  final String? title;
  final double? voteAverage;
  final String? posterPath;
  final String? overview;

  TMDbMovieCard({
    required this.id,
    required this.title,
    required this.voteAverage,
    this.posterPath,
    this.overview,
  });

  bool get hasPoster => posterPath != null;

  String get poster =>
      posterPath == null ? '' : imageBaseUrl + this.posterPath!;

  TMDbMovieCard copyWith({
    int? id,
    String? title,
    double? voteAverage,
    String? posterPath,
    String? overview,
  }) {
    return TMDbMovieCard(
      id: id ?? this.id,
      title: title ?? this.title,
      voteAverage: voteAverage ?? this.voteAverage,
      posterPath: posterPath ?? this.posterPath,
      overview: overview ?? this.overview,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'vote_average': voteAverage,
      'poster_path': posterPath,
      'overview': overview,
    };
  }

  factory TMDbMovieCard.fromJson(Map<String, dynamic> map) {
    return TMDbMovieCard(
      id: map['id'],
      title: map['title'],
      voteAverage: (map['vote_average'] as num).toDouble(),
      posterPath: map['poster_path'],
      overview: map['overview'],
    );
  }

  @override
  String toString() {
    return 'TMDbMovieCard('
        'id: $id, '
        'title: $title, '
        'vote_average: $voteAverage, '
        'poster_path: $posterPath, '
        'overview: $overview)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TMDbMovieCard &&
        other.id == id &&
        other.title == title &&
        other.voteAverage == voteAverage &&
        other.posterPath == posterPath &&
        other.overview == overview;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        voteAverage.hashCode ^
        posterPath.hashCode ^
        overview.hashCode;
  }
}
