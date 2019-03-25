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
            child: ListTile(
                subtitle: Image(
                    height: 150,
                    width: 180,
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(item.previewUrl)))));

    return makeListTile;
  }
}
