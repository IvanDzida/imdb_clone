import 'package:imdb_clone/feature/movies/models/movie_model.dart';
import 'package:sembast/sembast.dart';

class MoviesRepository {
  final Database database;
  late final StoreRef<int, Map<String, dynamic>> _store;

  MoviesRepository({required this.database}) {
    _store = intMapStoreFactory.store('movies_store');
  }

  /// insert movie in database
  Future<void> insertMovie(Movie movie) async {
    await _store.record(movie.id).put(database, movie.toMap());
  }

  /// return all movies
  Future<List<Movie>> getMovies() async {
    final data = await _store.find(database);

    return data
        .map(
          (item) => Movie.fromMap(item.value),
        )
        .toList();
  }

  /// update movie favourite status
  Future<bool> updateFavorite(Movie movie) async {
    movie.isFavourite = !movie.isFavourite!;

    final data = await _store.record(movie.id).put(
          database,
          movie.toMap(),
        );
    final updated = Movie.fromMap(data);
    return updated.isFavourite!;
  }
}
