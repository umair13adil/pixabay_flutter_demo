import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';

typedef ValueChanged<String> QueryCallback(String query);

class SearchWidget extends StatelessWidget {
  final TextEditingController editingController = TextEditingController();

  QueryCallback onQuerySubmitted;

  SearchWidget(this.onQuerySubmitted);

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
        margin: const EdgeInsets.only(),
        child: Material(
          borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
          elevation: 2.0,
          child: Container(
            height: 45.0,
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Theme.of(context).accentColor,
                      ),
                      hintText: Strings.searchHint,
                      border: InputBorder.none),
                  onSubmitted: onQuerySubmitted,
                  controller: editingController,
                ))
              ],
            ),
          ),
        ));
  }
}