import 'dart:async';

import 'package:flutter_showcase_app/bloc/bloc_base.dart';
import 'package:flutter_showcase_app/models/repository.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';

class SearchBloc extends BlocBase {
  static final SearchBloc _bloc = SearchBloc._internal();

  factory SearchBloc() => _bloc;

  SearchBloc._internal();

  final Repository _repo = Repository.get();

  final StreamController<List<Hit>> _searchControllerImages =
      StreamController<List<Hit>>.broadcast();

  final StreamController<List<Hit>> _searchControllerVideos =
  StreamController<List<Hit>>.broadcast();

  get searchResultsImages => _searchControllerImages.stream;

  get searchResultsVideos => _searchControllerVideos.stream;

  searchImages(String keyword) async {
    try {
      _searchControllerImages.sink.add(List());
      _repo.getSearchResultsForImages(keyword).then((list) {
        _searchControllerImages.sink.add(list);
      }).catchError((error) {
        _searchControllerImages.sink.addError(error);
      });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }
  
  searchVideos(String keyword) async {
    try {
      _searchControllerVideos.sink.add(List());
      _repo.getSearchResultsForVideos(keyword).then((list) {
        _searchControllerVideos.sink.add(list);
      }).catchError((error) {
        _searchControllerVideos.sink.addError(error);
      });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  @override
  void dispose() {
    //_searchControllerImages.close();
    //_searchControllerVideos.close();
  }
}
