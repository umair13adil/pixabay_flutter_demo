import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_showcase_app/bloc/bloc_provider.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/detail/detail_page.dart';
import 'package:flutter_showcase_app/ui/home/app_bar.dart';
import 'package:flutter_showcase_app/ui/search/list/search_list_item_grid.dart';
import 'package:flutter_showcase_app/ui/search/search_bloc.dart';
import 'package:flutter_showcase_app/utils/utils.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchScreenPageState();
}

class SearchScreenPageState extends State<SearchScreen> {

  String searchQuery = Utils.getRandomSearch();
  SearchBloc searchBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
          child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
              child: Column(
                children: <Widget>[
                  StreamBuilder<List<Hit>>(
                    stream: searchBloc.searchResults,
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
                ],
              )),
        )));
  }

  _buildSearchResultWidget(List<Hit> data) {
    if (data.length > 1) {
      return Column(
        children: <Widget>[_buildSearchWidget(), BuildListView(data)],
      );
    } else {
      if (data.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => DetailScreen(
                  //username: data.first.user,
                ),
          ));
        });
        return CircularProgressIndicator();
      }
    }
  }

  _buildSearchWidget() {
    return Column(
      children: <Widget>[
        _buildSearchField(),
        _buildSearchButton(),
        _buildDivider(),
      ],
    );
  }

  _searchForImages(BuildContext context) {
    print("Search: ${searchQuery}");
    searchBloc.search(searchQuery);
  }

  _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35.0, 0, 35.0, 0),
      child: TextField(
        decoration: InputDecoration(
            fillColor: Colors.grey.shade100,
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(12.0),
            ),
            hintText: Strings.enterSearchText),
        onChanged: (text) {
          searchQuery = text;
        },
      ),
    );
  }

  _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: RaisedButton(
          child: Text(Strings.searchText,
              style: TextStyle(color: AppColors.colorWhite, fontSize: 25)),
          color: AppColors.colorPrimary,
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
          onPressed: () {
            if (searchQuery.isNotEmpty) {
              searchBloc.search(searchQuery);
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            }
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0))),
    );
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
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List.generate(posts.length, (index) {
          return SearchListItemGrid(posts.elementAt(index));
        }));
  }

  /*@override
  Widget build(BuildContext context) {
    return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List.generate(posts.length, (index) {
          return SearchListItem(posts.elementAt(index));
        }));
  }*/
}
