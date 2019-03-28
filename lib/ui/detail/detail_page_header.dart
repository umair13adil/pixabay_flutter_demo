import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/bloc/bloc_provider.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/detail/detail_bloc.dart';
import 'package:flutter_showcase_app/utils/utils.dart';

class DetailPageHeaderWidget extends StatefulWidget {
  Hit item;

  DetailPageHeaderWidget({Key key, @required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailPageHeaderPageState(item: item);
}

class DetailPageHeaderPageState extends State<DetailPageHeaderWidget> {
  Hit item;
  DetailBloc detailBloc;

  DetailPageHeaderPageState({Key key, @required this.item});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double width_70 = width * 0.70;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildProfilePicture(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildUserName(width_70),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      _buildFollowersSection(),
                      _buildFollowingSection(),
                      _buildPostsSection(),
                    ],
                  ),
                ],
              ),
            ),
            BlocProvider<DetailBloc>(bloc: detailBloc, child: Container())
          ],
        ),
        _buildActionButtons(),
        _buildDivider()
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    detailBloc = DetailBloc();
    detailBloc.isAddedToFavourites(item);
  }

  @override
  void dispose() {
    detailBloc?.dispose();
    super.dispose();
  }

  _buildProfilePicture() {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            width: 75.0,
            height: 75.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(item.userImageUrl)))));
  }

  _buildUserName(double width_70) {
    return SizedBox(
        width: width_70,
        child: Container(
          padding: const EdgeInsets.only(left: 20.0, bottom: 10.0, top: 10.0),
          child: Text(item.user,
              softWrap: true,
              overflow: TextOverflow.clip,
              style: TextStyle(color: AppColors.colorTextDark2, fontSize: 14)),
        ));
  }

  _buildFollowersSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          Utils.formatCountText(item.comments),
          style: TextStyle(
              color: AppColors.colorTextDark2,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            Strings.commentsText,
            style: TextStyle(color: AppColors.colorTextDark2, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  _buildFollowingSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          Utils.formatCountText(item.downloads),
          style: TextStyle(
              color: AppColors.colorTextDark2,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            Strings.downloadsText,
            style: TextStyle(color: AppColors.colorTextDark2, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  _buildPostsSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          Utils.formatCountText(item.likes),
          style: TextStyle(
              color: AppColors.colorTextDark2,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            Strings.likesText,
            style: TextStyle(color: AppColors.colorTextDark2, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  _buildActionButtons() {
    return StreamBuilder<bool>(
        initialData: false,
        stream: detailBloc.userAddedToFavourite,
        builder: (context, snapshot) {
          return _buildAddToFavouritesButton(snapshot.data);
        });
  }

  _buildAddToFavouritesButton(bool isAdded) {
    return Padding(
        padding: const EdgeInsets.only(
            top: 5.0, bottom: 5.0, left: 5.0, right: 20.0),
        child: RaisedButton(
            child: !isAdded
                ? Text(Strings.addToFavouriteText,
                    style: TextStyle(color: AppColors.colorWhite, fontSize: 10))
                : Text(Strings.removeFromFavouriteText,
                    style:
                        TextStyle(color: AppColors.colorWhite, fontSize: 10)),
            color: AppColors.colorPrimary,
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
            onPressed: () {
              !isAdded
                  ? detailBloc.addToFavourite(item)
                  : detailBloc.removeFromFavourite(item);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0))));
  }

  _buildDivider() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 30.0, right: 30.0),
      child: Divider(
        color: AppColors.colorPrimary,
        indent: 18,
        height: 24,
      ),
    );
  }
}
