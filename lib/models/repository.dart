import 'dart:async';

import 'package:flutter_showcase_app/data/local/downloads/downloads_datasource.dart';
import 'package:flutter_showcase_app/data/local/favourites/favourites_datasource.dart';
import 'package:flutter_showcase_app/data/network/apis.dart';
import 'package:flutter_showcase_app/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';

class Repository {
  // api objects
  final _api = Apis();

  //Favourites DB
  final favDatasource = FavouritesDatasource();

  //Downloads DB
  final downloadDatasource = DownloadsDatasource();

  // shared pref object
  final _sharedPrefsHelper = SharedPreferenceHelper();

  // singleton repository object
  static final Repository _repository = Repository._internal();

  // named private constructor
  Repository._internal();

  // factory method to return the same object each time its needed
  factory Repository() => _repository;

  // General Methods: ----------------------------------------------------------
  static Repository get() => _repository;

  // Search: -------------------------------------------------------------------

  Future<List<Hit>> getSearchResults(String keyword) async {
    return _api
        .search(keyword)
        .then((response) => response)
        .catchError((error) => throw error);
  }
}
