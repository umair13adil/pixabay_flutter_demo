import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_showcase_app/bloc/bloc_provider.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/downloads/download_bloc.dart';
import 'package:flutter_showcase_app/ui/home/app_bar.dart';
import 'package:flutter_showcase_app/ui/home/app_bar_2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadProgressScreen extends StatefulWidget {
  final Hit candidate;

  DownloadProgressScreen({Key key, @required this.candidate}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      DownloadProgressScreenPageState(candidate);
}

class DownloadProgressScreenPageState extends State<DownloadProgressScreen> {
  final Hit candidate;
  TargetPlatform platform;
  DownloadBloc downloadBloc;

  DownloadProgressScreenPageState(this.candidate);

  Future<bool> _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    platform = Theme.of(context).platform;
    return WillPopScope(
      onWillPop: () {
        _onBackPressed(context);
      },
      child: Scaffold(
          appBar: AppBarBackWidget(),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                      child: Column(children: <Widget>[
                        StreamBuilder<int>(
                          stream: downloadBloc.downloadProgress,
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              return _buildProgress(snapshot.data);
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        BlocProvider<DownloadBloc>(
                            bloc: downloadBloc, child: Container())
                      ]))))),
    );
  }

  @override
  void initState() {
    super.initState();
    downloadBloc = DownloadBloc();
    _prepare();
    _checkPermission();
    downloadStory(candidate, context);
  }

  void downloadStory(Hit item, BuildContext context) async {
    _prepare().then((downloadPath) {
      print("Download Path: $downloadPath");

      Directory(downloadPath)
          .create(recursive: true)
          .then((Directory directory) {
        print('Path of New Dir: ' + directory.path);
      });

      _checkPermission().then((hasGranted) {
        if (hasGranted) {
          downloadBloc.downloadMedia(
              item.user, item.largeImageUrl, 1, downloadPath, context);
        } else {
          _checkPermission();
        }
      });
    });
  }

  @override
  void dispose() {
    FlutterDownloader.registerCallback(null);
    downloadBloc?.dispose();
    super.dispose();
  }

  _buildSaveButton() {
    return Container(
      child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.colorPrimary,
            ),
            child: IconTheme(
              data: IconThemeData(color: Colors.white),
              child: Icon(Icons.save),
            ),
          )),
    );
  }

  _buildProgress(int progress) {
    if (progress >= 100) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              Strings.downloadedText,
              style: TextStyle(
                  color: AppColors.colorPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          _buildSaveButton()
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              Strings.progressText,
              style: TextStyle(
                  color: AppColors.colorPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          LinearProgressIndicator(
            value: progress.toDouble(),
          )
        ],
      );
    }
  }

  Future<String> _prepare() async {
    await _checkPermission();
    return (await _findLocalPath() + '/Download');
  }

  Future<String> _findLocalPath() async {
    final directory = platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<bool> _checkPermission() async {
    try {
      if (platform == TargetPlatform.android) {
        PermissionStatus permission = await PermissionHandler()
            .checkPermissionStatus(PermissionGroup.storage);
        if (permission != PermissionStatus.granted) {
          Map<PermissionGroup, PermissionStatus> permissions =
              await PermissionHandler()
                  .requestPermissions([PermissionGroup.storage]);
          if (permissions[PermissionGroup.storage] ==
              PermissionStatus.granted) {
            return true;
          }
        } else {
          return true;
        }
      } else {
        return true;
      }
    } catch (e) {}
    return false;
  }
}
