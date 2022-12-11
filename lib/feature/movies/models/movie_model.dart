import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double? voteAverage;
  final int voteCount;
  bool? isFavourite;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.isFavourite,
  });

  Movie copyWith({
    bool? adult,
    String? backdropPath,
    bool? isFavourite,
  }) {
    return Movie(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  factory Movie.fromMap(Map<String, dynamic> data) => Movie(
        adult: data['adult'],
        backdropPath: data['backdrop_path'] ?? '',
        genreIds: List.castFrom<dynamic, int>(data['genre_ids']),
        id: data['id'],
        originalLanguage: data['original_language'],
        originalTitle: data['original_title'],
        overview: data['overview'],
        popularity: data['popularity'],
        posterPath: data['poster_path'],
        releaseDate: data['release_date'],
        title: data['title'],
        video: data['video'],
        voteAverage: data['vote_average'].toDouble(),
        voteCount: data['vote_count'],
        isFavourite: data['is_favourite'] ?? false,
      );

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['is_favourite'] = isFavourite!;
    return data;
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
        isFavourite,
      ];
}
