import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:flutter_showcase_app/data/network/rest_client.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/models/search/SearchResults.dart';

class Apis {
  // singleton object
  static final Apis _api = Apis._internal();

  // named private constructor
  Apis._internal();

  // factory method to return the same object each time its needed
  factory Apis() => _api;

  // rest client
  final _restClient = RestClient();

  Future<List<Hit>> searchImages(String keyword) async {
    String url = Strings.SEARCH_URL + keyword;

    var results = await _restClient
        .getHttps(url)
        .then((res) => SearchResults.fromJson(res).hits.toList())
        .catchError((error) => throw error);

    return results;
  }

  Future<List<Hit>> searchVideos(String keyword) async {
    String url = Strings.SEARCH_VIDEOS_URL + keyword;

    var results = await _restClient
        .getHttps(url)
        .then((res) => SearchResults.fromJson(res).hits.toList())
        .catchError((error) => throw error);

    return results;
  }
}
