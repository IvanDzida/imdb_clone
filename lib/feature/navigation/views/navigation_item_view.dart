import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb_clone/core/configs/styles/app_colors.dart';
import 'package:imdb_clone/feature/navigation/enums/navigation_item.dart';

import '../../home/views/home_page.dart';

class NavigationItemView extends StatelessWidget {
  final NavigationItem navigationItem;

  const NavigationItemView({required this.navigationItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        bool selected = ref.watch(tabIndexProvider) == navigationItem.index;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.ac_unit,
                color: selected ? AppColors.primary : AppColors.white,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                navigationItem.text,
                style: TextStyle(color: selected ? AppColors.primary : AppColors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
