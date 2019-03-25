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

  getUserDetails(String username) async {
    /*try {
      _repo.getUserDetails(username).then((result) {
        _userDetailsController.sink.add(result);
      }).catchError((error) {
        _userDetailsController.sink.addError(error);
      });
    } catch (e) {
      print("Error: " + e.toString());
    }*/
  }

  addToFavourite(Hit user) async {
    try {
      _repo.favDatasource
          .addToFavourite(Favourites(user.id, user.user, user.userImageUrl,
              user.largeImageUrl, user.tags.toString()))
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

  removeFromFavourite(Hit user) async {
    try {
      _repo.favDatasource
          .removeFromFavourite(Favourites(user.id, user.user, user.userImageUrl,
          user.largeImageUrl, user.tags.toString()))
          .then((result) {
        _userAddedToFavController.sink.add(false);
      }).catchError((error) {
        _userFavController.sink.addError(error);
      });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  isAddedToFavourites(Hit user) async {
    _repo.favDatasource.isAddedToFavourites(user).then((result) {
      _userAddedToFavController.sink.add(result);
    }).catchError((error) {
      _userAddedToFavController.sink.addError(error);
    });
  }

  @override
  void dispose() {
    //_userDetailsController.close();
  }
}
