import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb_clone/core/configs/styles/app_strings.dart';
import 'package:imdb_clone/feature/home/notifiers/home_state_notifier.dart';

import '../../../home/providers/home_state_provider.dart';
import '../../models/movie_error.dart';


class ErrorView extends StatelessWidget {
  final MovieError error;

  const ErrorView({required this.error, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            error.title,
            style: Theme.of(context).textTheme.headline3,
          ),
          Consumer(builder: (context, ref, child) {
            return TextButton(
              onPressed: () {
                ref.read(homeStateProvider.notifier).handleError();
              },
              child: const Text(
                AppStrings.tryAgain,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            );
          }),
          error.canClose
              ? Consumer(builder: (context, ref, child) {
                  return TextButton(
                    onPressed: () {
                      ref.read(homeStateProvider.notifier).continueUsingApp();
                    },
                    child: const Text(
                      AppStrings.close,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                })
              : Container(),
        ],
      ),
    );
  }
}
