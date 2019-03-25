import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/images_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/detail/video_player.dart';
import 'package:flutter_showcase_app/ui/downloads/download_progress.dart';

class StoryListItem extends StatefulWidget {
  final Hit storyItem;

  StoryListItem(this.storyItem);

  @override
  State<StatefulWidget> createState() => StoryListItemState(storyItem);
}

class StoryListItemState extends State<StoryListItem> {
  final Hit storyItem;

  StoryListItemState(this.storyItem);

  void _playVideo(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => VideoApp(storyItem.videos.large.url),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final makeListTile =
        ListTile(onTap: () => {}, title: _buildStoryItem(context));

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

  _buildStoryItem(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildStoryImage(),
        _buildDownloadButton(context),
        /*storyItem.media_type == 2
            ? _buildPlayButton(context)
            : Container() //Only draw button if media is Video*/
      ],
    );
  }

  _buildStoryImage() {
    return FadeInImage(
      placeholder: AssetImage(ImagesRef.APP_ICON),
      image: CachedNetworkImageProvider(storyItem.largeImageUrl),
      fit: BoxFit.cover,
      alignment: Alignment.center,
      fadeInDuration: Duration(milliseconds: 200),
      fadeInCurve: Curves.easeIn,
    );
  }

  _buildDownloadButton(BuildContext context) {
    return Positioned(
        bottom: 10,
        left: 10.0,
        child: FloatingActionButton(
          backgroundColor: AppColors.colorPrimary,
          child: Container(
              padding: EdgeInsets.all(5.0),
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(ImagesRef.APP_ICON)))),
          onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DownloadProgressScreen(candidate: storyItem,),
                    maintainState: true))
              },
          heroTag: null,
        ));
  }

  _buildPlayButton(BuildContext context) {
    return Positioned(
        bottom: 10,
        right: 10.0,
        child: FloatingActionButton(
          backgroundColor: AppColors.colorPrimary,
          child: Container(
              padding: EdgeInsets.all(5.0),
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.contain, image: AssetImage(ImagesRef.PLAY)))),
          onPressed: () => {_playVideo(context)},
          heroTag: null,
        ));
  }
}
