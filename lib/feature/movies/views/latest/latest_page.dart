import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/configs/styles/app_strings.dart';
import '../../../../views/loading_view.dart';
import '../../../genres/models/genre_model.dart';
import '../../../home/models/home_state.dart';
import '../../../home/notifiers/home_state_notifier.dart';
import '../../../home/providers/home_state_provider.dart';
import '../../../movie_detail/views/movie_item.dart';
import 'error_view.dart';

class LatestPage extends ConsumerWidget {
  late ScrollController _scrollController = ScrollController();

  LatestPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.2;
      if (maxScroll - currentScroll <= delta) {
        // load more movies
        ref.read(homeStateProvider.notifier).loadMovies();
      }
    });

    final state = ref.watch(homeStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 20),
          child: Text(
            AppStrings.popular,
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          ),
        ),
        Expanded(
          child: LayoutBuilder(builder: (
            context,
            child,
          ) {
            switch (state.viewType) {
              case HomeViewType.initial:
                return const LoadingView();
              case HomeViewType.loading:
                return const LoadingView();
              case HomeViewType.loaded:
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          controller: _scrollController,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              height: 20,
                            );
                          },
                          itemCount: state.movies!.length,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemBuilder: (context, index) {
                            List<Genre> genres =
                                ref.read(homeStateProvider.notifier).getGenres(state.movies![index].genreIds);
                            return MovieItem(
                              movie: state.movies![index],
                              genres: genres,
                            );
                          }),
                    ),
                    state.loadingMore
                        ? const Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(),
                          )
                        : Container()
                  ],
                );
              case HomeViewType.error:
                return ErrorView(error: state.error!);
            }
          }),
        ),
      ],
    );
  }
}
