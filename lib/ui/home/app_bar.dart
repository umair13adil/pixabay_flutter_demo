import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/routes_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  TabController _tabController;

  AppBarWidget(this._tabController);

  void _goToFavs(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.favourites);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(Strings.appName),
      backgroundColor: AppColors.colorPrimary,
      leading: IconButton(
        icon: Icon(Icons.favorite),
        onPressed: () {
          _goToFavs(context);
        },
      ),
      bottom: TabBar(
        isScrollable: true,
        controller: _tabController,
        indicatorColor: AppColors.tabIndicatorColor,
        indicatorPadding: const EdgeInsets.all(5),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 2.0,
        tabs: <Widget>[
          Tab(
            text: Strings.images,
          ),
          Tab(
            text: Strings.videos,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.0);
}
