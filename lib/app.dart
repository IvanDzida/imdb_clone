import 'package:flutter/material.dart';
import 'package:imdb_clone/core/configs/styles/app_themes.dart';

import 'package:imdb_clone/feature/home/views/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMDB clone',
      theme: AppThemes.darkTheme,
      darkTheme: AppThemes.darkTheme,
      home: HomePage(),
    );
  }
}
