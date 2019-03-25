import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "SaveStorie.db";
  static final _databaseVersion = 1;

  //Tables
  final table_favourites = 'favourites';
  final table_downloads = 'downloads';

  //Fields Common
  static final columnId = 'id';

  //Fields Favourites
  static final fav_columnUserName = 'username';
  static final fav_columnFullName = 'fullName';
  static final fav_columnImageURL = 'imageURL';
  static final fav_columnDescription = 'description';

  //Fields Downloads
  static final downloads_columnCaption = 'caption';
  static final downloads_columnIsVideo = 'is_video';
  static final downloads_columnURL = 'url';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table_favourites (
            $columnId INTEGER PRIMARY KEY,
            $fav_columnUserName TEXT NOT NULL,
            $fav_columnFullName TEXT NOT NULL,
            $fav_columnImageURL TEXT NOT NULL,
            $fav_columnDescription TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $table_downloads (
            $columnId INTEGER PRIMARY KEY,
            $downloads_columnCaption TEXT NOT NULL,
            $downloads_columnIsVideo TEXT NOT NULL,
            $downloads_columnURL TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // insert and update
  Future<int> insertOrUpdate(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;

    int id = row[columnId];
    //check to see if record already exist in DB
    List<Map> maps = await queryAllRowsWhere(tableName, id);

    //check to see if there is any data returned
    var result;
    if (maps.length > 0) {
      result = update(row, tableName);
    } else {
      result = insert(row, tableName);
    }

    return result;
  }

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRowsWhere(
      String tableName, int id) async {
    Database db = await instance.database;
    return await db.query(tableName,
        columns: [columnId], where: '$columnId = ?', whereArgs: [id]);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String tableName) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row, String tableName) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id, String tableName) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
