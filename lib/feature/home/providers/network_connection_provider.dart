import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb_clone/feature/home/notifiers/network_connection_notifier.dart';

final networkConnectionProvider = StateNotifierProvider(
  (ref) => NetworkConnectionNotifier(true),
);
