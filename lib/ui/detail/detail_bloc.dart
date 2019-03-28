import 'dart:async';

import 'package:flutter_showcase_app/bloc/bloc_base.dart';
import 'package:flutter_showcase_app/models/favourites/Favourites.dart';
import 'package:flutter_showcase_app/models/repository.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';

class DetailBloc extends BlocBase {
  static final DetailBloc _bloc = DetailBloc._internal();

  factory DetailBloc() => _bloc;

  DetailBloc._internal();

  final Repository _repo = Repository.get();

  final StreamController<Hit> _userDetailsController =
      StreamController<Hit>.broadcast();

  final StreamController<int> _userFavController =
      StreamController<int>.broadcast();

  final StreamController<bool> _userAddedToFavController =
      StreamController<bool>.broadcast();

  get userDetails => _userDetailsController.stream;

  get userFavourite => _userFavController.stream;

  get userAddedToFavourite => _userAddedToFavController.stream;

  addToFavourite(Hit item) async {
    try {
      _repo.favDatasource
          .addToFavourite(_getFavouriteObject(item))
          .then((result) {
        _userFavController.sink.add(result);
        _userAddedToFavController.sink.add(true);
      }).catchError((error) {
        _userFavController.sink.addError(error);
      });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  removeFromFavourite(Hit item) async {
    try {
      _repo.favDatasource
          .removeFromFavourite(_getFavouriteObject(item))
          .then((result) {
        _userAddedToFavController.sink.add(false);
      }).catchError((error) {
        _userFavController.sink.addError(error);
      });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  isAddedToFavourites(Hit item) async {
    _repo.favDatasource.isAddedToFavourites(item).then((result) {
      _userAddedToFavController.sink.add(result);
    }).catchError((error) {
      _userAddedToFavController.sink.addError(error);
    });
  }

  Favourites _getFavouriteObject(Hit item) {
    if (item.type == Type.photo) {
      return Favourites(
          item.id,
          item.user,
          item.comments.toString(),
          item.downloads.toString(),
          item.likes.toString(),
          item.userImageUrl,
          item.largeImageUrl,
          "false",
          item.tags.toString());
    } else
      return Favourites(
          item.id,
          item.user,
          item.comments.toString(),
          item.downloads.toString(),
          item.likes.toString(),
          item.userImageUrl,
          item.videos.medium.url,
          "true",
          item.tags.toString());
  }

  @override
  void dispose() {
    //_userDetailsController.close();
  }
}
