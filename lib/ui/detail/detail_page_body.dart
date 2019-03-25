import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:flutter_showcase_app/models/search/Hit.dart';
import 'package:flutter_showcase_app/ui/detail/story_list_item.dart';

class UserStoryWidget extends StatefulWidget {
  Hit item;

  UserStoryWidget({Key key, @required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserStoryWidgetPageState(item: item);
}

class UserStoryWidgetPageState extends State<UserStoryWidget> {
  Hit item;

  UserStoryWidgetPageState({Key key, @required this.item});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Text(
          item.tags,
          style: TextStyle(
              color: AppColors.colorPrimary,
              fontSize: 30,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        StoryListItem(item)
      ],
    );
  }
}
