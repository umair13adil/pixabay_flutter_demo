import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_showcase_app/bloc/bloc_provider.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/search/list/search_list_item_grid.dart';
import 'package:flutter_showcase_app/ui/search/search.dart';
import 'package:flutter_showcase_app/ui/search/search_bloc.dart';

class VideosScreen extends StatefulWidget {
  String searchQuery;

  VideosScreen(this.searchQuery);

  @override
  State<StatefulWidget> createState() => VideosScreenPageState(searchQuery);
}

class VideosScreenPageState extends State<VideosScreen>
    with AutomaticKeepAliveClientMixin<VideosScreen> {
  String searchQuery;
  SearchBloc searchBloc;

  VideosScreenPageState(this.searchQuery);

  ValueChanged<String> querySubmitted(String q) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    searchBloc.searchVideos(q);
  }

  @override
  bool get wantKeepAlive => true;

  _buildSearchWidget() {
    return Column(
      children: <Widget>[
        SearchWidget(querySubmitted),
        _buildDivider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                child: Column(children: <Widget>[
                  StreamBuilder<List<Hit>>(
                    stream: searchBloc.searchResultsVideos,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.isNotEmpty) {
                        searchQuery = ""; //Clear search query on result
                        return _buildSearchResultWidget(snapshot.data);
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData && snapshot.data.isEmpty) {
                        return Column(
                          children: <Widget>[
                            _buildSearchWidget(),
                            CircularProgressIndicator()
                          ],
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  BlocProvider<SearchBloc>(bloc: searchBloc, child: Container())
                ]))));
  }

  _buildSearchResultWidget(List<Hit> data) {
    return Column(
      children: <Widget>[_buildSearchWidget(), BuildListView(data)],
    );
  }

  _searchForVideos(BuildContext context) {
    searchBloc.searchVideos(searchQuery);
  }

  _buildDivider() {
    return Divider(
      color: AppColors.colorPrimary,
      indent: 4,
      height: 24,
    );
  }

  @override
  void initState() {
    searchBloc = SearchBloc();
    _searchForVideos(context);
    super.initState();
  }

  @override
  void dispose() {
    searchBloc?.dispose();
    super.dispose();
  }
}

class BuildListView extends StatefulWidget {
  final List<Hit> posts;

  const BuildListView(this.posts);

  @override
  State<StatefulWidget> createState() => BuildListViewState(posts);
}

class BuildListViewState extends State<BuildListView> {
  final List<Hit> posts;

  BuildListViewState(this.posts);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        padding: EdgeInsets.all(0.0),
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List.generate(posts.length, (index) {
          return SearchListItemGrid(posts.elementAt(index));
        }));
  }
}
