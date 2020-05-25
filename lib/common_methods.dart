import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_launcher/map_launcher.dart';

class Common {
  static void _showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static openMaps(
    context,
    String title,
    double lat,
    double lng,
  ) async {
    MapType mapType = Platform.isIOS ? MapType.apple : MapType.google;
    print([lat, lng]);
    try {
      if (lat == 0.0 && lng == 0.0) {
        _showToast(context, 'Location unavailable!');
        return;
      }

      //Check for iOS and Android
      if (await MapLauncher.isMapAvailable(mapType)) {
        await MapLauncher.launchMap(
          mapType: mapType,
          coords: Coords(lat, lng),
          title: title,
          description: title,
        );
      } else {
        //Show no supported map
        _showToast(context,
            'Please make sure you have ${mapType == MapType.apple ? 'Apple Maps' : 'Google Maps'} installed!');
      }
    } catch (e) {
      print(e);
      _showToast(context, e);
    }
  }
}
