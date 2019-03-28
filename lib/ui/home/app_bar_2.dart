import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/routes_const.dart';
import 'package:flutter_showcase_app/ui/favourites/favourites.dart';

class AppBarBackWidget extends StatelessWidget implements PreferredSizeWidget {

  void _goBack(BuildContext context) {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorPrimary,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            _goBack(context);
          })
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55.0);
}
