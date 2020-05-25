import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './configurations/constants.dart';
import './configurations/themeData.dart';
import './screens/regionList/region_list_screen.dart';
import './screens/stationDetails/station_details_screen.dart';
import './screens/stationList/station_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white));
    }
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: RegionListScreen(),
      routes: {
        ROUTE_REGIONS_SCREEN: (ctx) => RegionListScreen(),
        ROUTE_STATION_LIST_SCREEN: (ctx) => StationListScreen(),
        ROUTE_STATION_DETAILS_SCREEN: (ctx) => StationDetailScreen(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute (
        builder: (context) => RegionListScreen(),
      ),
    );
  }
}
