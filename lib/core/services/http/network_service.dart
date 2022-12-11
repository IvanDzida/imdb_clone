import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb_clone/feature/movie_detail/models/movie_detail_model.dart';

import '../../../feature/genres/models/genre_model.dart';
import '../../../feature/movies/models/movie_model.dart';

class NetworkService {
  static const String genre = 'genre/movie/list';
  static const String movie = 'movie/popular?language=en_US&page=';
  static const String movieDetail = 'movie/';

  late final Dio _dio = Dio(
    BaseOptions(
      headers: {
        'api_key': 'b8d7f76947904a011286dc732c55234e',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOGQ3Zjc2OTQ3OTA0YTAxMTI4NmRjNzMyYzU1MjM0ZSIsInN1YiI6IjYwMzM3ODBiMTEzODZjMDAzZjk0ZmM2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XYuIrLxvowrkevwKx-KhOiOGZ2Tn-R8tEksXq842kX4',
      },
      baseUrl: 'https://api.themoviedb.org/3/',
    ),
  );

  /// Fetch genres
  ///
  /// example:
  Future<AsyncValue<List<Genre>>> fetchGenres() async {
    log('fetchGenres', name: 'NetworkService');
    List<Genre> genres = [];
    try {
      var response = await _dio.get(genre);
      var data = response.data['genres'] as List;
      genres = (data).map((e) => Genre.fromMap(e)).toList();

      return AsyncValue.data(genres);
    } on DioError catch (err) {
      log('${err.message}, with stackTrace: ${err.stackTrace.toString()}', name: 'NetworkService');
      return AsyncValue.error(err, err.stackTrace!);
    } catch (e) {
      log(e.toString(), name: 'NetworkService');
      return AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Fetch movies by passed page
  ///
  /// example: https://api.themoviedb.org/3/movie/popular?language=en_US&page=1
  Future<AsyncValue<List<Movie>>> fetchMovies(int page) async {
    List<Movie> movies;
    try {
      var response = await _dio.get('$movie$page');
      var data = response.data['results'] as List;
      movies = (data).map((item) => Movie.fromMap(item)).toList();

      return AsyncValue.data(movies);
    } on DioError catch (err) {
      log('${err.message}, with stackTrace: ${err.stackTrace.toString()}', name: 'NetworkService');
      return AsyncValue.error(err, err.stackTrace!);
    } catch (e) {
      log(e.toString(), name: 'NetworkService');
      return AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Fetch movie details
  ///
  /// example: https://api.themoviedb.org/3/movie/508947?api_key=b8d7f76947904a011286dc732c55234e&language=en_US&page=1
  Future<AsyncValue<MovieDetail>> fetchMovieDetails(int id) async {
    log('fetchMovieDetails', name: 'NetworkService');
    try {
      var response = await _dio.get('movie/$id');
      var data = MovieDetail.fromJson(response.data);

      return AsyncData(data);
    } on DioError catch (err) {
      log('${err.message}, with stackTrace: ${err.stackTrace.toString()}', name: 'NetworkService');
      return AsyncValue.error(err, err.stackTrace!);
    } catch (e) {
      log(e.toString(), name: 'NetworkService');
      return AsyncValue.error(e, StackTrace.current);
    }
  }
}
