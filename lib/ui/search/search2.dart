import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:flutter_showcase_app/ui/search/search.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController editingController = TextEditingController();

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

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
                  onSubmitted: onSubmitted,
                  controller: editingController,
                ))
              ],
            ),
          ),
        ));
  }

  onSubmitted(query) {
    Navigator.of(_context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return SearchScreen(query);
    }));
  }
}
