import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imdb_clone/core/configs/styles/app_strings.dart';
import '../../../core/configs/styles/app_colors.dart';
import '../../../core/services/http/network_service.dart';
import '../../genres/models/genre_model.dart';
import '../../home/notifiers/home_state_notifier.dart';
import '../../home/providers/home_state_provider.dart';
import '../models/movie_detail_model.dart';
import '../../movies/models/movie_model.dart';
import '../../../views/genre_item.dart';
import '../../../views/vote_widget.dart';

final movieDetailProvider = FutureProvider.family.autoDispose<AsyncValue<MovieDetail>, int>(
  (ref, id) async {
    return await NetworkService().fetchMovieDetails(id);
  },
);

class MovieDetailPage extends ConsumerWidget {
  final Movie movie;

  const MovieDetailPage({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 500,
            bottom: PreferredSize(
              child: Container(),
              preferredSize: const Size(0, 20),
            ),
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Hero(
                tag: movie.id,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      color: AppColors.background,
                      imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                      width: double.maxFinite,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -1,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 20,
                        decoration: const BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Hero(
                          tag: movie.title,
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              movie.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: Theme.of(context).textTheme.headline3,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Consumer(
                        builder: (context, ref, child) {
                          final isFavourite = ref.watch(homeStateProvider).favouriteMovies!.contains(movie);

                          return Material(
                            color: Colors.transparent,
                            child: IconButton(
                              splashColor: AppColors.primary,
                              splashRadius: 24,
                              onPressed: () async {
                                await ref.read(homeStateProvider.notifier).updateFavourite(movie);
                              },
                              icon: SvgPicture.asset(
                                isFavourite ? 'assets/icons/bookmarked.svg' : 'assets/icons/bookmark.svg',
                                color: isFavourite ? AppColors.primary : AppColors.white,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  VoteWidget(vote: movie.voteAverage!),
                  const SizedBox(
                    height: 16,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 4,
                      direction: Axis.horizontal,
                      children: List.generate(
                        movie.genreIds.length,
                        (index) {
                          List<Genre> genres = ref.read(homeStateProvider.notifier).getGenres(movie.genreIds);
                          return GenreItem(genre: genres[index]);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    AppStrings.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
