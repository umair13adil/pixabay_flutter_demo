
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/ui/detail/detail_page.dart';
import 'package:flutter_showcase_app/ui/downloads/download_progress.dart';
import 'package:flutter_showcase_app/ui/downloads/downloads.dart';
import 'package:flutter_showcase_app/ui/favourites/favourites.dart';
import 'package:flutter_showcase_app/ui/search/search.dart';
import 'package:flutter_showcase_app/ui/splash/splash.dart';
import 'constants/routes_const.dart' as rc;

class Routes {
  static final routes = <String, WidgetBuilder>{
    rc.Routes.splash: (BuildContext context) => SplashScreen(),
    rc.Routes.search: (BuildContext context) => SearchScreen(),
    rc.Routes.detail: (BuildContext context) => DetailScreen(),
    rc.Routes.favourites: (BuildContext context) => FavouritesScreen(),
    rc.Routes.downloads: (BuildContext context) => DownloadsScreen(),
    rc.Routes.downloadProgress: (BuildContext context) => DownloadProgressScreen(),
  };
}
