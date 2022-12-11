import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imdb_clone/core/configs/styles/app_colors.dart';

class EmptyView extends StatelessWidget {
  final String title;
  final String svgPath;
  const EmptyView({
    required this.title,
    required this.svgPath,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(svgPath, height: 60, width: 60,color: AppColors.white,),
          const SizedBox(height: 20),
          Text(title, style: Theme.of(context).textTheme.headline3,),
        ],
      ),
    );
  }
}
