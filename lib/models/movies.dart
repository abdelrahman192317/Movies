import '../apis/urls.dart';

class Movie {
  final int id;
  final String title;
  final double rate;
  String posterPath = "";
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.rate,
    required String path,
    required this.releaseDate
  }) {
    posterPath = "${Urls.imageBaseUrl}$path";
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] ?? '',
      path: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      rate: map['vote_average']?.toDouble() ?? 0.0,
    );
  }
}

class MovieDetails {
  final int id;
  final String title;
  final double rate;
  String posterPath = "";
  String backdropPath = "";
  final String overview;
  final double popularity;
  final String releaseDate;
  final int voteCount;

  MovieDetails({
    required this.id,
    required this.title,
    required this.rate,
    required String pPath,
    required String bPath,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.voteCount
  }) {
    posterPath = "${Urls.imageBaseUrl}$pPath";
    backdropPath = "${Urls.imageBaseUrl}$bPath";
  }

  factory MovieDetails.fromMap(Map<String, dynamic> map) {
    return MovieDetails(
      id: map['id'] as int,
      title: map['title'] ?? '',
      pPath: map['poster_path'] ?? '',
      bPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      rate: map['vote_average']?.toDouble() ?? 0.0,
      popularity: map['popularity']?.toDouble() ?? 0.0,
      voteCount: map['vote_count']?.toInt() ?? 0
    );
  }
}