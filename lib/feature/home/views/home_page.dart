import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imdb_clone/core/configs/styles/app_colors.dart';
import 'package:imdb_clone/feature/navigation/enums/navigation_item.dart';

import 'package:imdb_clone/feature/navigation/views/navigation_item_view.dart';
import '../../movies/views/favourites/views/favourites_page.dart';
import '../../movies/views/latest/latest_page.dart';
import '../providers/network_connection_provider.dart';

final tabIndexProvider = StateProvider((ref) => 0);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    )..addListener(() {
        ref.read(tabIndexProvider.notifier).state = _tabController.index;
      });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(networkConnectionProvider.notifier, (previous, next) {
      // listen network status
    });
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
            height: 20,
            width: 20,
          ),
        ),
        elevation: 0,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          LatestPage(),
          FavouritesPage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.navigationBar,
        height: 60,
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicator: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
          ),
          padding: const EdgeInsets.all(0),
          controller: _tabController,
          tabs: const [
            NavigationItemView(
              navigationItem: NavigationItem.movies,
            ),
            NavigationItemView(
              navigationItem: NavigationItem.favourites,
            ),
          ],
        ),
      ),
    );
  }
}
