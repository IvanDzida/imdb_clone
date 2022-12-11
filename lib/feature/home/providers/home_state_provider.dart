
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../top_level_providers.dart';
import '../../genres/repository/genres_repository.dart';
import '../models/home_state.dart';
import '../notifiers/home_state_notifier.dart';

final homeStateProvider = StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier(
    genresRepository: ref.watch(genresRepositoryProvider),
    moviesRepository: ref.watch(moviesRepositoryProvider),
  );
});