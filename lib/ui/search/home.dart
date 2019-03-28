import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/ui/home/app_bar.dart';
import 'package:flutter_showcase_app/ui/home/images_screen.dart';
import 'package:flutter_showcase_app/ui/home/videos_screen.dart';
import 'package:flutter_showcase_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchScreenPageState();
}

class SearchScreenPageState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBarWidget(_tabController),
            backgroundColor: Colors.white,
            body: TabBarView(controller: _tabController, children: <Widget>[
              ImagesScreen(Utils.getRandomSearch()),
              VideosScreen(Utils.getRandomSearch())
            ])));
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
