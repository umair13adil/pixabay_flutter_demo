import 'dart:async';

import 'package:flutter_showcase_app/bloc/bloc_base.dart';
import 'package:flutter_showcase_app/models/repository.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';

class SearchBloc extends BlocBase {
  static final SearchBloc _bloc = SearchBloc._internal();

  factory SearchBloc() => _bloc;

  SearchBloc._internal();

  final Repository _repo = Repository.get();

  final StreamController<List<Hit>> _searchController =
      StreamController<List<Hit>>.broadcast();

  get searchResults => _searchController.stream;

  search(String keyword) async {
    try {
      _searchController.sink.add(List());
      _repo.getSearchResults(keyword).then((list) {
        _searchController.sink.add(list);
      }).catchError((error) {
        _searchController.sink.addError(error);
      });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  @override
  void dispose() {
    //_searchController.close();
  }
}
