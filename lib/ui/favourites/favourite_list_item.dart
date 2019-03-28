import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/models/favourites/Favourites.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/models/search/Large.dart';
import 'package:flutter_showcase_app/models/search/Videos.dart';
import 'package:flutter_showcase_app/ui/detail/detail_page.dart';
import 'package:flutter_showcase_app/ui/favourites/fav_bloc.dart';
import 'package:flutter_showcase_app/utils/utils.dart';

class FavouritesListItem extends StatelessWidget {
  FavBloc favBloc;
  final Favourites fav;

  FavouritesListItem(this.fav, this.favBloc);

  void _onTileClicked(BuildContext context, Favourites item) {
    Hit itemHit = Hit();
    itemHit.id = item.id;
    itemHit.user = item.username;
    itemHit.comments = int.parse(item.comments);
    itemHit.downloads = int.parse(item.downloads);
    itemHit.likes = int.parse(item.likes);
    itemHit.tags = item.tags;
    itemHit.userImageUrl = item.userImage;

    if (item.isVideo == "true") {
      itemHit.videos = Videos(medium: Large(url: item.contentUrl));
      itemHit.type = Type.film;
    } else if (item.isVideo == "false") {
      itemHit.largeImageUrl = item.contentUrl;
      itemHit.type = Type.photo;
    }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailScreen(item: itemHit),
        maintainState: true));
  }

  void _removeFromFavourites() {
    favBloc.deleteFavourite(fav);
  }

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(
      onTap: () => _onTileClicked(context, fav),
      title: Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildUserProfilePic(),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildFullName(),
                    _buildDownloads(),
                    _buildUserName()
                  ],
                ),
              ),
              _buildActionButtons()
            ],
          )),
    );

    return Card(
        elevation: 4.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.black12),
          child: makeListTile,
        ));
  }

  _buildUserProfilePic() {
    return Container(
        width: 55.0,
        height: 55.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.contain,
                image: CachedNetworkImageProvider(fav?.userImage))));
  }

  _buildFullName() {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 100.0),
        child: Text(
          fav?.username,
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: AppColors.colorTextDark,
              fontWeight: FontWeight.normal,
              fontSize: 12),
        ));
  }

  _buildUserName() {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 100.0),
        child: Text(
          fav?.tags,
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(
              color: AppColors.colorTextDark,
              fontWeight: FontWeight.normal,
              fontSize: 12),
        ));
  }

  _buildDownloads() {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 100.0),
        child: Text(
          "${Utils.formatCountText(int.parse(fav.downloads))}",
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(
              color: AppColors.colorTextDark,
              fontWeight: FontWeight.normal,
              fontSize: 12),
        ));
  }

  _buildRemoveFromFavouritesButton() {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: InkWell(
          onTap: () => _removeFromFavourites(),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.colorPrimary,
            ),
            child: IconTheme(
              data: IconThemeData(color: Colors.white),
              child: Icon(Icons.delete),
            ),
          )),
    );
  }

  _buildNavigateButton() {
    return Container(
      child: InkWell(
          child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.colorPrimary,
        ),
        child: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Icon(Icons.arrow_forward_ios),
        ),
      )),
    );
  }

  _buildActionButtons() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildRemoveFromFavouritesButton(),
        _buildNavigateButton()
      ],
    ));
  }
}
