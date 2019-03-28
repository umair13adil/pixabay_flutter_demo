import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_showcase_app/bloc/bloc_provider.dart';
import 'package:flutter_showcase_app/models/downloads/Downloaded.dart';
import 'package:flutter_showcase_app/ui/downloads/download_bloc.dart';
import 'package:flutter_showcase_app/ui/favourites/fav_bloc.dart';
import 'package:flutter_showcase_app/ui/home/app_bar.dart';
import 'package:flutter_showcase_app/ui/home/app_bar_2.dart';

class DownloadsScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => DownloadsScreenPageState();
}

class DownloadsScreenPageState extends State<DownloadsScreen> {

  DownloadBloc downloadBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarBackWidget(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
              child: Column(
                children: <Widget>[
                  StreamBuilder<List<Downloaded>>(
                    initialData: _getDownloaded(context),
                    stream: downloadBloc.downloads,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.isNotEmpty) {
                        return _buildSearchResultWidget(snapshot.data);
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData && snapshot.data.isEmpty) {
                        return CircularProgressIndicator();
                      } else {
                        return Container();
                      }
                    },
                  ),
                  BlocProvider<DownloadBloc>(bloc: downloadBloc, child: Container())
                ],
              )),
        )));
  }

  _buildSearchResultWidget(List<Downloaded> data) {
    return BuildListView(data);
  }

  _getDownloaded(BuildContext context) {
    downloadBloc.getDownloads();
  }
  
  @override
  void initState() {
    super.initState();
    downloadBloc = DownloadBloc();
  }

  @override
  void dispose() {
    downloadBloc?.dispose();
    super.dispose();
  }
}

class BuildListView extends StatefulWidget {
  final List<Downloaded> downloads;

  const BuildListView(this.downloads);

  @override
  State<StatefulWidget> createState() => BuildListViewState(downloads);
}

class BuildListViewState extends State<BuildListView> {
  final List<Downloaded> downloads;

  BuildListViewState(this.downloads);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        primary: true,
        shrinkWrap: true,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        scrollDirection: Axis.vertical,
        children: List.generate(downloads.length, (index) {
          //return SearchListItem(downloads.elementAt(index));
        }));
  }
}
