import 'package:equatable/equatable.dart';

import '../../genres/models/genre_model.dart';
import '../../movies/models/movie_error.dart';
import '../../movies/models/movie_model.dart';

class HomeState extends Equatable {
  HomeViewType viewType;
  MovieError? error;
  List<Genre>? genres;
  List<Movie>? movies;
  List<Movie>? favouriteMovies;
  bool loadingMore = false;
  bool showError = false;

  HomeState({
    required this.viewType,
    required this.error,
    required this.genres,
    required this.movies,
    required this.favouriteMovies,
    required this.loadingMore,
    required this.showError,
  });

  HomeState copyWith({
    HomeViewType? viewType,
    MovieError? error,
    List<Genre>? genres,
    List<Movie>? movies,
    List<Movie>? favouriteMovies,
    bool? loadingMore,
    bool? showError,
  }) {
    return HomeState(
      viewType: viewType ?? this.viewType,
      error: error ?? this.error,
      genres: genres ?? this.genres,
      movies: movies ?? this.movies,
      favouriteMovies: favouriteMovies ?? this.favouriteMovies,
      loadingMore: loadingMore ?? this.loadingMore,
      showError: showError ?? this.showError,
    );
  }

  HomeState.initial()
      : viewType = HomeViewType.initial,
        error = null,
        genres = null,
        movies = null,
        favouriteMovies = null,
        loadingMore = false,
        showError = false;

  @override
  List<Object?> get props => [
        viewType,
        error,
        genres,
        movies,
        favouriteMovies,
        loadingMore,
        showError,
      ];
}

enum HomeViewType {
  initial,
  loading,
  loaded,
  error,
}
