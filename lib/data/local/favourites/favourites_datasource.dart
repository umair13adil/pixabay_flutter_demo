import 'package:flutter_showcase_app/data/local/DatabaseHelper.dart';
import 'package:flutter_showcase_app/data/local/favourites/favourites_dao.dart';
import 'package:flutter_showcase_app/models/favourites/Favourites.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';

class FavouritesDatasource {
  // singleton object
  static final FavouritesDatasource _favDatasource =
      FavouritesDatasource._internal();

  // named private constructor
  FavouritesDatasource._internal();

  // factory method to return the same object each time its needed
  factory FavouritesDatasource() => _favDatasource;

  final dbHelper = DatabaseHelper.instance;

  // Favorites: ----------------------------------------------------------------

  Future<int> addToFavourite(Favourites fav) async {
    // row to insert
    Map<String, dynamic> row = FavouritesDAO.fromObject(fav).toMap();
    final id = await dbHelper.insertOrUpdate(row, dbHelper.table_favourites);
    print('Added User to favorites: $id');
    return id;
  }

  Future<List<Favourites>> getAllFavourites() async {
    List<Favourites> list = List();

    var result = await dbHelper.queryAllRows(dbHelper.table_favourites);

    result.forEach((row) => {list.add(FavouritesDAO.fromMap(row).toObject())});

    return list;
  }

  Future removeFromFavourite(Favourites user) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted =
        await dbHelper.delete(user.pk, dbHelper.table_favourites);
    print('Removed $rowsDeleted row(s): row $user.pk');
  }

  Future<bool> isAddedToFavourites(Hit user) async {
    var result =
    await dbHelper.queryAllRowsWhere(dbHelper.table_favourites, user.id);

    return result.length > 0;
  }
}
