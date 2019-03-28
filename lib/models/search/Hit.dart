import 'package:flutter_showcase_app/models/search/Videos.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Hit.g.dart';

@JsonSerializable()
class Hit {
  String largeImageUrl;
  int webformatHeight;
  int webformatWidth;
  int likes;
  int imageWidth;
  int id;
  int userId;
  int views;
  int comments;
  String pageUrl;
  int imageHeight;
  String webformatUrl;
  Type type;
  int previewHeight;
  String tags;
  int downloads;
  String user;
  int favorites;
  int imageSize;
  int previewWidth;
  String userImageUrl;
  String previewUrl;
  String pictureId;
  Videos videos;
  int duration;

  Hit(
      {this.largeImageUrl,
      this.webformatHeight,
      this.webformatWidth,
      this.likes,
      this.imageWidth,
      this.id,
      this.userId,
      this.views,
      this.comments,
      this.pageUrl,
      this.imageHeight,
      this.webformatUrl,
      this.type,
      this.previewHeight,
      this.tags,
      this.downloads,
      this.user,
      this.favorites,
      this.imageSize,
      this.previewWidth,
      this.userImageUrl,
      this.previewUrl,
      this.pictureId,
      this.videos,
      this.duration});

  factory Hit.fromJson(Map<String, dynamic> json) => _$HitFromJson(json);

  Map<String, dynamic> toJson() => _$HitToJson(this);

  @override
  String toString() {
    return 'Hit{pictureId: $pictureId, videos: $videos, duration: $duration, largeImageUrl: $largeImageUrl, webformatHeight: $webformatHeight, webformatWidth: $webformatWidth, likes: $likes, imageWidth: $imageWidth, id: $id, userId: $userId, views: $views, comments: $comments, pageUrl: $pageUrl, imageHeight: $imageHeight, webformatUrl: $webformatUrl, type: $type, previewHeight: $previewHeight, tags: $tags, downloads: $downloads, user: $user, favorites: $favorites, imageSize: $imageSize, previewWidth: $previewWidth, userImageUrl: $userImageUrl, previewUrl: $previewUrl}';
  }
}

enum Type { photo, film, animation, illustration, vector }
