import 'package:flutter/material.dart';
import 'package:station_locator/configurations/themeData.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const CustomScaffold({@required this.title, @required this.body});

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Locator'),
      backgroundColor: Colors.white.withOpacity(0.03),
      elevation: 0,
      centerTitle: false,
      leading: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(2),
        child: CircleAvatar(child: Image.asset('./assets/images/batman_avatar.png'),
          radius: 50,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBarTitle: 'Locator',
          height: 100,
        ),
        body: body);
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final appBarTitle;

  CustomAppBar({@required this.height, @required this.appBarTitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + spacingNormal,
        bottom: spacingHalf.toDouble(),
        left: spacingNormal.toDouble(),
        right: spacingNormal.toDouble(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appBarTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(2),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://cdn.dribbble.com/users/258358/screenshots/3306125/artboard.png',
                  scale: 55),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
