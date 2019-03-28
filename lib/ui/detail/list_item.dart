import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/downloads/download_progress.dart';
import 'package:video_player/video_player.dart';

class DetailListItem extends StatefulWidget {
  final Hit item;

  DetailListItem(this.item);

  @override
  State<StatefulWidget> createState() => DetailListItemState(item);
}

class DetailListItemState extends State<DetailListItem> {
  final Hit item;
  ChewieController chewieController;

  DetailListItemState(this.item);

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(onTap: () => {}, title: _buildItem(context));

    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(color: AppColors.colorWhite),
        padding: const EdgeInsets.all(0.0),
        child: makeListTile,
      ),
    );
  }

  _buildItem(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildContent(), //Only draw button if media is Video*/
        _buildDownloadButton(context),
      ],
    );
  }

  _buildContent() {
    if (item.type == Type.photo) {
      return _buildImage();
    } else if (item.type == Type.film) {
      return _buildVideoPlayer();
    } else
      return Container();
  }

  _buildImage() {
    return CachedNetworkImage(
          imageUrl: item.largeImageUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fadeOutDuration: Duration(seconds: 1),
          fadeInDuration: Duration(seconds: 2),
          fit: BoxFit.cover,
          fadeInCurve: Curves.easeIn,
          alignment: Alignment.center,
    );
  }

  _buildDownloadButton(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Text(Strings.downloadText),
          onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DownloadProgressScreen(
                          candidate: item,
                        ),
                    maintainState: true))
              },
          color: AppColors.colorPrimary,
          textColor: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          splashColor: Colors.grey,
        ));
  }

  _buildVideoPlayer() {
    if (item.videos.medium.url != null && item.videos.medium.url.isNotEmpty) {
      chewieController = ChewieController(
          videoPlayerController:
              VideoPlayerController.network(item.videos.medium.url),
          //aspectRatio: 3 / 4,
          autoPlay: true,
          looping: true,
          autoInitialize: true,
          showControls: true);

      return Container(
          margin: const EdgeInsets.all(2.0),
          child: Chewie(controller: chewieController));
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    chewieController?.dispose();
    super.dispose();
  }
}
