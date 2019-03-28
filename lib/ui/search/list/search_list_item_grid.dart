import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/images_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/detail/detail_page.dart';

class SearchListItemGrid extends StatelessWidget {
  final Hit item;

  SearchListItemGrid(this.item);

  void _onTileClicked(BuildContext context, Hit user) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailScreen(
              item: item,
            ),
        maintainState: true));
  }

  @override
  Widget build(BuildContext context) {
    final makeListTile = GridTile(
        child: InkResponse(
            onTap: () => _onTileClicked(context, item),
            child: item.type == Type.photo
                ? _buildPreviewForPhoto()
                : item.type == Type.film
                    ? _buildPreviewForVideo(context)
                    : Container()));

    return makeListTile;
  }

  _buildPreviewForPhoto() {
    if (item.previewUrl != null && item.previewUrl.isNotEmpty) {
      return Container(
          margin: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              color: Colors.black54,
              image: DecorationImage(
                image: CachedNetworkImageProvider(item.previewUrl),
                fit: BoxFit.cover,
              )));
    } else {
      return Container();
    }
  }

  _buildPreviewForVideo(BuildContext context) {
    if (item.pictureId != null && item.pictureId.isNotEmpty) {
      var preview_url = Strings.FETCH_VIDEO_PREVIEW_URL +
          item.pictureId +
          Strings.IMAGE_PREVIEW_SIZE;

      return Stack(children: <Widget>[
        Container(
            margin: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                color: Colors.black54,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(preview_url),
                  fit: BoxFit.cover,
                ))),
        Positioned(
          bottom: 10.0,
          top: 10.0,
          left: 10.0,
          right: 10.0,
          child: FloatingActionButton(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Container(
                padding: EdgeInsets.all(5.0),
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(ImagesRef.PLAY)))),
            onPressed: () => {_onTileClicked(context, item)},
            heroTag: null,
          ),
        )
      ]);
    } else {
      return Container();
    }
  }
}
