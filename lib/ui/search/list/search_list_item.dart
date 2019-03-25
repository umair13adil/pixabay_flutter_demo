import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/detail/detail_page.dart';
import 'package:flutter_showcase_app/utils/utils.dart';

class SearchListItem extends StatelessWidget {
  final Hit item;

  SearchListItem(this.item);

  void _onTileClicked(BuildContext context, Hit user) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailScreen(
              //username: item.user,
            ),
        maintainState: true));
  }

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(
      onTap: () => _onTileClicked(context, item),
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
                    _buildFollowers(),
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
                image: CachedNetworkImageProvider(item.largeImageUrl ?? ''))));
  }

  _buildFullName() {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 100.0),
        child: Text(
          item?.user,
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.fade,
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
          item?.user,
          softWrap: true,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(
              color: AppColors.colorTextDark,
              fontWeight: FontWeight.normal,
              fontSize: 12),
        ));
  }

  _buildFollowers() {
    return Text(
      Utils.formatFollowersText(item.downloads),
      softWrap: true,
      maxLines: 1,
      overflow: TextOverflow.fade,
      style: TextStyle(
          color: AppColors.colorTextDark,
          fontWeight: FontWeight.normal,
          fontSize: 12),
    );
  }

  _buildPrivateButton() {
    return Container(
      child: InkWell(
          onTap: () => {},
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.colorPrimary,
            ),
            child: IconTheme(
              data: IconThemeData(color: Colors.white),
              child: Icon(Icons.lock),
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
        _buildNavigateButton(),
      ],
    ));
  }
}
