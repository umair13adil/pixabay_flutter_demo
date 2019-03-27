import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            child: Container(
                margin: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(item.previewUrl),
                      fit: BoxFit.cover,
                    )))));

    return makeListTile;
  }
}
