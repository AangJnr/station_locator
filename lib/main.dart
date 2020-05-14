import 'dart:io';

import 'package:flutter/material.dart';
import 'package:station_locator/data.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

import './models/radio_station.dart';
import './theme_Info.dart';
import './widgets/custom_scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locator',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: CustomScaffold(title: 'Locator', body: MainBody()),
    );
  }
}

//Main Body whic is stateful

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  var _radioStationData =
      DATA.map((element) => RadioStation.fromJson(element)).toList();
  var copy = List<RadioStation>();

  _MainBodyState() {
    copy.addAll(_radioStationData);
  }
  final _searchController = TextEditingController();

  _performSearch() {
    print('${_searchController.text}');
    if (_searchController.text.isNotEmpty) {
      setState(() {
        _radioStationData = copy
            .where((element) => element.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ))
            .toList();
        print('${_radioStationData.length}');
      });
    } else
      setState(() {
        _radioStationData = copy;
        print('${_radioStationData.length}');
      });
  }

  void _showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _openMaps(context, String title, double lat, double lng) async {
    try {
      if (lat == 0.0 && lng == 0.0) {
        _showToast(context, 'Location unavailable!');
        return;
      }

      //Check for iOS and Android
      var mapType = Platform.isIOS ? MapType.apple : MapType.google;
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

  Widget _buildSearchView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.09),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: TextField(
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "Search",
          suffixIcon: _searchController.text.isNotEmpty ? IconButton(
            onPressed: () => _searchController.clear(),
            icon: Icon(
              Icons.clear,
              color: Colors.white38,
            ),
          ) : null,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.white.withOpacity(0.5)),
          fillColor: Colors.white,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext ctx, RadioStation station) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openMaps(ctx, station.name, station.lat, station.lng),
        splashColor: Theme.of(ctx).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: EdgeInsets.all(paddingNormal),
          child: Row(children: [
            Container(
              alignment: Alignment.center,
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(paddingNormal),
              child: Text(
                station.name.substring(0, 1),
                style: Theme.of(ctx).textTheme.headline6,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(ctx).accentColor.withOpacity(0.6),
                    Theme.of(ctx).accentColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(70),
              ),
            ),
            SizedBox(width: paddingNormal),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${station.name}',
                    style: Theme.of(ctx).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.offline_bolt,
                        size: 18,
                        color: colorPrimary,
                      ),
                      const SizedBox(
                        width: paddingQuarter,
                      ),
                      Text(
                        '${station.frequency}',
                        style: Theme.of(ctx)
                            .textTheme
                            .subtitle1
                            .copyWith(fontSize: 13, color: colorPrimary),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: paddingNormal,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.white38,
                      ),
                      const SizedBox(
                        width: paddingQuarter,
                      ),
                      Text(
                        station.richLocationString(),
                        style: Theme.of(ctx).textTheme.subtitle2.copyWith(
                              color: Colors.white38,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingNormal),
      child: Column(
        children: [
          _buildSearchView(context),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) =>
                  _buildListItem(ctx, _radioStationData[index]),
              itemCount: _radioStationData.length,
            ),
          )
        ],
      ),
    );
  }
}
