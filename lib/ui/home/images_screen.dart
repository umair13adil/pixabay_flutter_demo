import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/bloc/bloc_provider.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/search/list/search_list_item_grid.dart';
import 'package:flutter_showcase_app/ui/search/search.dart';
import 'package:flutter_showcase_app/ui/search/search_bloc.dart';

class ImagesScreen extends StatefulWidget {
  String searchQuery;

  ImagesScreen(this.searchQuery);

  @override
  State<StatefulWidget> createState() => ImagesScreenPageState(searchQuery);
}

class ImagesScreenPageState extends State<ImagesScreen> {
  String searchQuery;
  SearchBloc searchBloc;

  ImagesScreenPageState(this.searchQuery);

  ValueChanged<String> querySubmitted(String q) {
    searchBloc.searchImages(q);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                child: Column(children: <Widget>[
                  StreamBuilder<List<Hit>>(
                    stream: searchBloc.searchResultsImages,
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
                            Text(
                              Strings.noResults,
                              style: TextStyle(
                                  color: AppColors.colorPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              softWrap: true,
                            )
                          ],
                        );
                      } else {
                        return Column(
                          children: <Widget>[
                            _buildSearchWidget(),
                            CircularProgressIndicator()
                          ],
                        );
                      }
                    },
                  ),
                  BlocProvider<SearchBloc>(bloc: searchBloc, child: Container())
                ]))));
  }

  _buildSearchWidget() {
    return Column(
      children: <Widget>[
        SearchWidget(querySubmitted),
        _buildDivider(),
      ],
    );
  }

  _buildSearchResultWidget(List<Hit> data) {
    return Column(
      children: <Widget>[_buildSearchWidget(), BuildListView(data)],
    );
  }

  _searchForImages(BuildContext context) {
    searchBloc.searchImages(searchQuery);
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
    super.initState();
    searchBloc = SearchBloc();
    _searchForImages(context);
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
