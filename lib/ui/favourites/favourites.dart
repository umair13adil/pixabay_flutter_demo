import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/bloc/bloc_provider.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:flutter_showcase_app/models/favourites/Favourites.dart';
import 'package:flutter_showcase_app/ui/favourites/fav_bloc.dart';
import 'package:flutter_showcase_app/ui/favourites/favourite_list_item.dart';
import 'package:flutter_showcase_app/ui/home/app_bar_2.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavouritesScreenPageState();
}

class FavouritesScreenPageState extends State<FavouritesScreen> {
  FavBloc favBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarBackWidget(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
          child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Column(
                children: <Widget>[
                  StreamBuilder<List<Favourites>>(
                    stream: favBloc.favourites,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.isNotEmpty) {
                        return _buildSearchResultWidget(snapshot.data);
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData && snapshot.data.isEmpty) {
                        return _buildHeading();
                      } else {
                        return _buildHeading();
                      }
                    },
                  ),
                  BlocProvider<FavBloc>(bloc: favBloc, child: Container())
                ],
              )),
        )));
  }

  _buildSearchResultWidget(List<Favourites> data) {
    return Column(
      children: <Widget>[_buildHeading(), BuildListView(data, favBloc)],
    );
  }

  _buildHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.star_border,
          color: AppColors.colorPrimary,
          size: 40.0,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            Strings.favouritesText,
            style: TextStyle(
                color: AppColors.colorPrimary,
                fontSize: 25,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    favBloc = FavBloc();
    favBloc.getFavourites();
  }

  @override
  void dispose() {
    favBloc?.dispose();
    super.dispose();
  }
}

class BuildListView extends StatefulWidget {
  final List<Favourites> users;
  FavBloc favBloc;

  BuildListView(this.users, this.favBloc);

  @override
  State<StatefulWidget> createState() => BuildListViewState(users, favBloc);
}

class BuildListViewState extends State<BuildListView> {
  final List<Favourites> users;
  FavBloc favBloc;

  BuildListViewState(this.users, this.favBloc);

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List.generate(users.length, (index) {
          return FavouritesListItem(users.elementAt(index), favBloc);
        }));
  }
}
