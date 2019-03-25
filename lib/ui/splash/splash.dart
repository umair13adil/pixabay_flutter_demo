import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_showcase_app/constants/colors_const.dart';
import 'package:flutter_showcase_app/constants/images_const.dart';
import 'package:flutter_showcase_app/constants/routes_const.dart';
import 'package:flutter_showcase_app/constants/strings_const.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1),
        () => Navigator.of(context).pushReplacementNamed(Routes.search));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(ImagesRef.APP_ICON,
                  color: AppColors.colorWhite,
                  fit: BoxFit.fill),
            ),
            Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  Strings.website,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: AppColors.colorWhite),
                ))
          ],
        ),
      ),
    );
  }
}
