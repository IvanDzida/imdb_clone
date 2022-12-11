import 'package:flutter/material.dart';

import '../feature/genres/models/genre_model.dart';

class GenreItem extends StatelessWidget {
  final Genre genre;

  const GenreItem({required this.genre, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.0)), color: Color(0x33EC9B3E)),
      child: Text(
        genre.name,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
