
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:station_locator/configurations/themeData.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final isHomeScreen;
  CustomAppBar({this.title, this.isHomeScreen = false});

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Column(children: [
      SizedBox(
        height: isLandscape ? spacingNormal : appBarMaginTop,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingNormal),
        child: Row(
          children: [
            if (!isHomeScreen)
              IconButton(
                  iconSize: 20,
                  splashColor: colorPrimary,
                  icon: Icon(FontAwesomeIcons.arrowLeft),
                  onPressed: () => Navigator.pop(context)),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            Spacer(),
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('./assets/images/ghana_flag.jpg'),
            ),
          ],
        ),
      )
    ]);
  }
}
