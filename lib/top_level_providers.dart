import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';

import 'feature/movies/repository/movies_repository.dart';

final databaseProvider = Provider<Database>(
  (_) => throw Exception('Database not initialized'),
);

final moviesRepositoryProvider = Provider((ref) {
  return MoviesRepository(
    database: ref.watch(databaseProvider),
  );
});
