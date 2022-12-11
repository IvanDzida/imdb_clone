import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imdb_clone/feature/movie_detail/views/movie_detail_page.dart';

import '../../../core/configs/styles/app_colors.dart';
import '../../genres/models/genre_model.dart';
import '../../home/notifiers/home_state_notifier.dart';
import '../../home/providers/home_state_provider.dart';
import '../../movies/models/movie_model.dart';
import '../../../views/genre_item.dart';

import '../../../views/vote_widget.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final List<Genre> genres;

  const MovieItem({required this.movie, required this.genres, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(
              movie: movie,
            ),
          ),
        );
      },
      borderRadius: const BorderRadius.all(Radius.circular(2.0)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Hero(
              tag: movie.id,
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                height: 100,
                width: 100,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Hero(
                          transitionOnUserGestures: true,
                          tag: movie.title,
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              movie.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.start,
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Consumer(builder: (context, ref, child) {
                      return IconButton(
                        splashRadius: 24,
                        splashColor: AppColors.primary,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          ref.read(homeStateProvider.notifier).updateFavourite(movie);
                        },
                        icon: SvgPicture.asset(
                          movie.isFavourite! ? 'assets/icons/bookmarked.svg' : 'assets/icons/bookmark.svg',
                          color: movie.isFavourite! ? AppColors.primary : Colors.white,
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(
                  height: 4.0,
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
                      genres.length,
                      (index) => GenreItem(genre: genres[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 14,
          ),
        ],
      ),
    );
  }
}
