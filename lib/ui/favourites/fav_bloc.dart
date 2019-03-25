import 'dart:async';

import 'package:flutter_showcase_app/bloc/bloc_base.dart';
import 'package:flutter_showcase_app/models/favourites/Favourites.dart';
import 'package:flutter_showcase_app/models/repository.dart';

class FavBloc extends BlocBase {
  static final FavBloc _bloc = FavBloc._internal();

  factory FavBloc() => _bloc;

  FavBloc._internal();

  final Repository _repo = Repository.get();

  final StreamController<List<Favourites>> _favController =
      StreamController<List<Favourites>>.broadcast();

  get favourites => _favController.stream;

  getFavourites() async {
    try {
      _favController.sink.add(List());
      _repo.favDatasource.getAllFavourites().then((list) {
        _favController.sink.add(list);
      }).catchError((error) {
        _favController.sink.addError(error);
      });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  deleteFavourite(Favourites fav) async {
    try {
      _favController.sink.add(List());
      _repo.favDatasource.removeFromFavourite(fav);
      getFavourites();
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  @override
  void dispose() {
    //_favController.close();
  }
}
