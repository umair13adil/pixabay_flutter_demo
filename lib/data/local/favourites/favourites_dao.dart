import 'package:flutter_showcase_app/models/favourites/Favourites.dart';

class FavouritesDAO {
  int id;
  String username;
  String fullName;
  String imageURL;
  String description;

  FavouritesDAO(
      this.id, this.username, this.fullName, this.imageURL, this.description);

  FavouritesDAO.fromObject(Favourites favourites)
      : this(favourites.pk, favourites.username, favourites.full_name,
            favourites.image_url, favourites.description);

  FavouritesDAO.fromMap(Map<String, dynamic> map)
      : this(map['id'], map['username'], map['fullName'], map['imageURL'],
            map['description']);

  toObject() {
    return Favourites(id, username, fullName, imageURL, description);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'imageURL': imageURL,
      'description': description,
    };
  }
}
