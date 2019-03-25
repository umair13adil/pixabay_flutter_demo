import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/ui/home/app_bar_2.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends StatefulWidget {
  final String video_url;

  VideoApp(this.video_url);

  @override
  _VideoAppState createState() => _VideoAppState(video_url);
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  final String video_url;

  _VideoAppState(this.video_url);

  @override
  void initState() {
    super.initState();

    _videoPlayerController1 = VideoPlayerController.network(video_url);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: deviceRatio,
      autoPlay: true,
      looping: true,
      allowFullScreen: true,
      allowMuting: true,
      showControls: true,
    );

    return Scaffold(
        appBar: AppBarBackWidget("2"),
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.all(35.0),
              child: Transform.scale(
                alignment: Alignment.center,
                scale: _videoPlayerController1.value.aspectRatio / deviceRatio,
                child: AspectRatio(
                  aspectRatio: _videoPlayerController1.value.aspectRatio,
                  child: Chewie(controller: _chewieController),
                ),
              ),
            )
          ]))
        ]));
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
