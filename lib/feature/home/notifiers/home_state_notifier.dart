import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb_clone/core/services/http/network_service.dart';
import 'package:imdb_clone/feature/home/models/home_state.dart';
import 'package:imdb_clone/feature/movies/models/movie_model.dart';
import 'package:imdb_clone/top_level_providers.dart';

import '../../genres/models/genre_model.dart';
import '../../genres/repository/genres_repository.dart';
import '../../movies/models/movie_error.dart';
import '../../movies/repository/movies_repository.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {
  final GenresRepository genresRepository;
  final MoviesRepository moviesRepository;
  int page = 1;

  List<Movie> allMovies = [];
  List<Movie> favouriteMovies = [];

  HomeStateNotifier({
    required this.genresRepository,
    required this.moviesRepository,
  }) : super(HomeState.initial()) {
    loadGenres();
  }

  loadGenres() async {
    state = state.copyWith(viewType: HomeViewType.initial);
    List<Genre> localGenres = await genresRepository.getGenres();
    if (localGenres.isEmpty) {
      AsyncValue data = await NetworkService().fetchGenres();
      if (data.hasError) {
        log('Some error happened', name: 'HomeStateNotifier');
        state = state.copyWith(viewType: HomeViewType.error, error: MovieError.initial);
      } else {
        List<Genre> genres = data.value;
        for (var genre in genres) {
          localGenres.add(genre);
          await genresRepository.insertGenre(genre);
        }

        state = state.copyWith(genres: localGenres);
        await initialLoad();
      }
    } else {
      state = state.copyWith(genres: localGenres);
      await initialLoad();
    }

  }

  initialLoad() async {
    /*state = state.copyWith(viewType: HomeViewType.loading, error: null);*/
    allMovies = await moviesRepository.getMovies();
    if (allMovies.isEmpty) {
      page = 1;
      loadMovies();
    } else {
      page = (allMovies.length / 20).round() + 1;
      for (var movie in allMovies) {
        if (movie.isFavourite!) {
          favouriteMovies.add(movie);
        }
      }
      state = state.copyWith(viewType: HomeViewType.loaded, movies: allMovies, favouriteMovies: favouriteMovies);
    }
  }

  handleError() {
    switch(state.error!){
      case MovieError.initial:
        loadGenres();
        break;
      case MovieError.loadMovies:
        state = state.copyWith(viewType: HomeViewType.loaded, loadingMore: false, error: null);
        loadMovies();
        break;
      case MovieError.loadMore:
        state = state.copyWith(viewType: HomeViewType.loaded, loadingMore: false, error: null);
        loadMovies();
        break;
    }
  }

  continueUsingApp() {
    state = state.copyWith(viewType: HomeViewType.loaded, loadingMore: false, error: null);
  }

  ////final data = await _store.find(database, finder: Finder(limit: lastIndex, offset: startIndex));
  loadMovies() async {
    /*if(state.error != null) {
      switch(state.error) {
        case MovieError.loadMovies:
          state = state.copyWith(viewType: HomeViewType.loading, error: null);
        case: Movie
      }
    }*/
    //if(state.error!)
    log('Load more for page: $page', name: 'HomeStateNotifier');
    if (!state.loadingMore) {
      state = state.copyWith(loadingMore: true);
      AsyncValue data = await NetworkService().fetchMovies(page);
      if (data.hasError) {
        log('Some error happened', name: 'HomeStateNotifier');
        state = state.copyWith(
          viewType: HomeViewType.error, error: (page == 1) ? MovieError.loadMovies : MovieError.loadMore,);
      } else {
        List<Movie> movies = data.value;

        //List<Movie> movies = await MoviesService().fetchMovies(page);
        //page++;

        for (var movie in movies) {
          allMovies.add(movie);
          await moviesRepository.insertMovie(movie);
        }
        // allMovies.addAll(movies);
        page++;
        state = state.copyWith(viewType: HomeViewType.loaded, movies: allMovies, favouriteMovies: favouriteMovies, loadingMore: false, error: null);
      }
    } else {
      log('Loading more already in progress, just skip', name: 'HomeStateNotifier');
    }
  }

  /// Get genres by passed list of ids
  List<Genre> getGenres(List<int> ids) {
    List<Genre> movieGenres = [];
    for (var genre in state.genres!) {
      if (ids.contains(genre.id)) {
        movieGenres.add(genre);
      }
    }

    return movieGenres;
  }

  /// Update isFavourite value for passed [movie]
  Future<void> updateFavourite(Movie movie) async {
    final updateStatus = await moviesRepository.updateFavorite(movie);
    if (updateStatus) {
      log('currently movie.isFavourite: ${movie.isFavourite}', name: 'HomeStateNotifier');
      favouriteMovies.add(movie);
    } else {
      log('${movie.title} not favourite anymore, remove it', name: 'HomeStateNotifier');
      favouriteMovies.remove(movie);
    }
    log('${movie.title} lastestStatus: ${movie.isFavourite}', name: 'HomeStateNotifier');
    state = state.copyWith(movies: allMovies, favouriteMovies: favouriteMovies);
  }
}
