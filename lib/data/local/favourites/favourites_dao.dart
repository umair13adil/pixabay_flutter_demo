import 'package:flutter_showcase_app/models/favourites/Favourites.dart';

class FavouritesDAO {
  int id;
  String username;
  String comments;
  String downloads;
  String likes;
  String userImage;
  String contentUrl;
  String isVideo;
  String tags;

  FavouritesDAO(this.id, this.username, this.comments, this.downloads,
      this.likes, this.userImage, this.contentUrl, this.isVideo, this.tags);

  FavouritesDAO.fromObject(Favourites favourites)
      : this(favourites.id,
            favourites.username,
            favourites.comments,
            favourites.downloads,
            favourites.likes,
            favourites.userImage,
            favourites.contentUrl,
            favourites.isVideo,
            favourites.tags);

  FavouritesDAO.fromMap(Map<String, dynamic> map)
      : this(
          map['id'],
          map['username'],
          map['comments'],
          map['downloads'],
          map['likes'],
          map['userImage'],
          map['contentUrl'],
          map['isVideo'],
          map['tags'],
        );

  toObject() {
    return Favourites(id, username, comments, downloads, likes, userImage, contentUrl, isVideo, tags);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'comments': comments,
      'downloads': downloads,
      'likes': likes,
      'userImage': userImage,
      'contentUrl': contentUrl,
      'isVideo': isVideo,
      'tags': tags,
    };
  }
}
