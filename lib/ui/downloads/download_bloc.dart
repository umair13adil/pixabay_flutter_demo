import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_showcase_app/bloc/bloc_base.dart';
import 'package:flutter_showcase_app/models/downloads/Downloaded.dart';
import 'package:flutter_showcase_app/models/repository.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';

class DownloadBloc extends BlocBase {
  static final DownloadBloc _bloc = DownloadBloc._internal();

  factory DownloadBloc() => _bloc;

  DownloadBloc._internal();

  final Repository _repo = Repository.get();

  final StreamController<List<Downloaded>> _downloadController =
      StreamController<List<Downloaded>>.broadcast();

  final StreamController<int> _downloadProgress =
      StreamController<int>.broadcast();

  get downloads => _downloadController.stream;

  get downloadProgress => _downloadProgress.stream;

  getDownloads() async {
    try {
      _downloadController.sink.add(List());
      _repo.downloadDatasource.getAllDownloaded().then((list) {
        _downloadController.sink.add(list);
      }).catchError((error) {
        _downloadController.sink.addError(error);
      });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  Future downloadMedia(
      Hit item, String downloadPath, BuildContext context) async {
    String userName = item.user;
    String filename = "${userName}_${DateTime.now().millisecondsSinceEpoch}";

    String downloadURL;

    if (item.type == Type.photo) {
      filename = "$filename.jpg";
      downloadURL = item.largeImageUrl;
    } else {
      filename = "$filename.mp4";
      downloadURL = item.videos.large.url;
    }

    String taskId = await FlutterDownloader.enqueue(
        url: downloadURL,
        savedDir: downloadPath,
        fileName: filename,
        showNotification: false,
        openFileFromNotification: false);

    /*final tasks = await FlutterDownloader.loadTasksWithRawQuery(
        query: "SELECT * FROM task WHERE task_id=$taskId");
    tasks?.forEach((file) {
      print("Downloaded file name: ${file.filename}");
      filename = file.filename;
    });*/

    FlutterDownloader.registerCallback((id, status, progress) async {
      // code to update your UI
      print("Download Status: " +
          status.toString() +
          " Progress: " +
          progress.toString());
      _downloadProgress.sink.add(progress.toInt());

      if (progress.toInt() >= 100) {
        print("Download Completed!");

        /*String newFilename = filename;
        if (mediaType == 2) {
          newFilename = "$filename.mp4";
        } else {
          newFilename = "$filename.jpg";
        }*/

        _downloadProgress.sink.add(100);

        FlutterDownloader.open(taskId: taskId);

        /*Future.delayed(const Duration(milliseconds: 500), () {
          File(downloadPath + "/" + filename)
              .renameSync(downloadPath + "/" + newFilename);
          print("Download File renamed!");
        });*/
      }
    });
  }

  @override
  void dispose() {
    //_downloadController.close();
    //_downloadProgress.close();
  }
}
