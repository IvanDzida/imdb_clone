import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb_clone/core/configs/styles/app_strings.dart';

import '../../../../genres/models/genre_model.dart';
import '../../../../home/notifiers/home_state_notifier.dart';
import '../../../../home/providers/home_state_provider.dart';
import '../../../../movie_detail/views/movie_item.dart';
import 'empty_view.dart';

class FavouritesPage extends ConsumerWidget {
  FavouritesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(
            AppStrings.favourites,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Expanded(
          child: state.favouriteMovies!.isEmpty
              ? const EmptyView(
                  title: 'Currently, no movies in favourites',
                  svgPath: 'assets/icons/movies.svg',
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 20,
                    );
                  },
                  itemCount: state.favouriteMovies!.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    List<Genre> genres =
                        ref.read(homeStateProvider.notifier).getGenres(state.favouriteMovies![index].genreIds);
                    return MovieItem(
                      movie: state.favouriteMovies![index],
                      genres: genres,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
