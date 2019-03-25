import 'package:flutter_showcase_app/data/local/DatabaseHelper.dart';
import 'package:flutter_showcase_app/models/downloads/Downloaded.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';

class DownloadsDatasource {
  // singleton object
  static final DownloadsDatasource _downloadsDatasource =
      DownloadsDatasource._internal();

  // named private constructor
  DownloadsDatasource._internal();

  // factory method to return the same object each time its needed
  factory DownloadsDatasource() => _downloadsDatasource;

  final dbHelper = DatabaseHelper.instance;

  // Downloads: ----------------------------------------------------------------

  void saveDownloaded(Downloaded info) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: info.hashCode,
      DatabaseHelper.downloads_columnCaption: "",
      DatabaseHelper.downloads_columnIsVideo: "",
      DatabaseHelper.downloads_columnURL: info.video_url
    };
    final id = await dbHelper.insert(row, dbHelper.table_downloads);
    print('Added Info to downloads: $id');
  }

  Future<List<Downloaded>> getAllDownloaded() async {
    List<Downloaded> list = List();

    List<Map> result = await dbHelper.queryAllRows(dbHelper.table_downloads);
    result.forEach((row) => {
          //list.add(Downloaded(row[''],))
          print(row)
        });

    return list;
  }

  void removeDownloadInfo(Hit info) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted =
        await dbHelper.delete(info.hashCode, dbHelper.table_downloads);
    print('Removed $rowsDeleted row(s): row ${info.hashCode}');
  }
}
