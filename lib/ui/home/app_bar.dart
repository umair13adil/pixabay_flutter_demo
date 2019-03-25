import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/routes_const.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  void _goToFavs(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(Routes.favourites);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorPrimary,
      leading: IconButton(
        icon: Icon(Icons.favorite),
        onPressed: () {
          _goToFavs(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55.0);
}
