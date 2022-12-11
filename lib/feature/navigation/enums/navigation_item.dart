import 'package:flutter/material.dart';
import 'package:imdb_clone/core/configs/styles/app_colors.dart';
import 'package:imdb_clone/core/configs/styles/app_strings.dart';

enum NavigationItem {
  movies(
      text: AppStrings.movies,
      iconPath: 'assets/icons/movies.svg',
      regularColor: AppColors.text,
      selectedColor: AppColors.primary),
  favourites(
      text: AppStrings.favourites,
      iconPath: 'assets/icons/bookmark_checked.svg',
      regularColor: AppColors.text,
      selectedColor: AppColors.primary);

  final String text;
  final String iconPath;
  final Color regularColor;
  final Color selectedColor;

  const NavigationItem({
    required this.text,
    required this.iconPath,
    required this.regularColor,
    required this.selectedColor,
  });
}
