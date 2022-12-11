import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';

import '../../../top_level_providers.dart';
import '../models/genre_model.dart';

final genresRepositoryProvider = Provider((ref) {
  return GenresRepository(
    database: ref.watch(databaseProvider),
  );
});

class GenresRepository {
  final Database database;
  final StoreRef _store = StoreRef<String?, Map<String, dynamic>>('genre_store');

  GenresRepository({required this.database});

  Future<void> insertGenre(Genre genre) async {
    await _store.add(database, genre.toMap());
  }

  Future<List<Genre>> getGenres() async {
    final data = await _store.find(database);

    return data.map((item) => Genre.fromMap(item.value)).toList();
  }
}
