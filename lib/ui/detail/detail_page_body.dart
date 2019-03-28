import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/detail/list_item.dart';

class DetailContentWidget extends StatefulWidget {
  Hit item;

  DetailContentWidget({Key key, @required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailContentWidgetPageState(item: item);
}

class DetailContentWidgetPageState extends State<DetailContentWidget> {
  Hit item;

  DetailContentWidgetPageState({Key key, @required this.item});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Text(
          item.tags,
          style: TextStyle(
              color: AppColors.colorPrimary,
              fontSize: 20,
              fontWeight: FontWeight.normal),
          textAlign: TextAlign.center,
        ),
        DetailListItem(item)
      ],
    );
  }
}
