import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/routes_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarBackWidget extends StatelessWidget implements PreferredSizeWidget {
  String _actionType;

  AppBarBackWidget(this._actionType);

  void _goBack(BuildContext context) {
    //Navigator.pop(context, true);
    Navigator.of(context).pushReplacementNamed(Routes.search);
  }

  _launchURL() async {
    const url = '';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorPrimary,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            _goBack(context);
          }),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5)),
          child: OutlineButton(
            child: _showActionTypeText(),
            textColor: AppColors.colorWhite,
            onPressed: () {
              _showActionType(context);
            },
          ),
        ),
      ],
    );
  }

  _showActionType(BuildContext context) {
    if (_actionType == "1") {
      _launchURL();
    } else {

    }
  }

  _showActionTypeText() {
    if (_actionType == "1") {
      return Text(Strings.goBackText,
          style: TextStyle(
              color: AppColors.colorWhite,
              fontWeight: FontWeight.normal,
              fontSize: 12));
    } else {
      return Text(Strings.goBackText,
          style: TextStyle(
              color: AppColors.colorWhite,
              fontWeight: FontWeight.normal,
              fontSize: 12));
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(55.0);
}
