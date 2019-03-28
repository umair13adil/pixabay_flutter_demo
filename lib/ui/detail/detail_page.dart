import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/bloc/bloc_provider.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/detail/detail_bloc.dart';
import 'package:flutter_showcase_app/ui/detail/detail_page_body.dart';
import 'package:flutter_showcase_app/ui/detail/detail_page_header.dart';
import 'package:flutter_showcase_app/ui/home/app_bar_2.dart';

class DetailScreen extends StatefulWidget {
  Hit item;

  DetailScreen({Key key, @required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailScreenState(item);
}

class DetailScreenState extends State<DetailScreen> {
  Hit item;

  DetailBloc detailBloc;

  DetailScreenState(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarBackWidget(),
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          _buildUserDetails(),
          _buildContent(),
          _userAddedToFavListener(),
          SliverList(
              delegate: SliverChildListDelegate([
            BlocProvider<DetailBloc>(bloc: detailBloc, child: Container())
          ]))
        ]));
  }

  _buildProgressBar() {
    return Center(child: CircularProgressIndicator());
  }

  _buildUserDetails() {
    try {
      return SliverList(
          delegate:
              SliverChildListDelegate([DetailPageHeaderWidget(item: item)]));
    } catch (e) {
      return Container();
    }
  }

  _buildContent() {
    try {
      return SliverList(
          delegate: SliverChildListDelegate([DetailContentWidget(item: item)]));
    } catch (e) {
      return Container();
    }
  }

  _userAddedToFavListener() {
    return SliverList(
        delegate: SliverChildListDelegate([
      StreamBuilder<int>(
          stream: detailBloc.userFavourite,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                try {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Added to favourite!')));
                } catch (e) {}
                return Container();
              }
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("${snapshot.error}");
            } else {
              return Container();
            }
          })
    ]));
  }

  @override
  void initState() {
    super.initState();
    detailBloc = DetailBloc();
  }

  @override
  void dispose() {
    detailBloc?.dispose();
    super.dispose();
  }
}
