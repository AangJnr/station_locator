import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:recase_string_extension/recase.dart';

import '../../configurations/themeData.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/search_view.dart';
import '../../configurations/constants.dart';
import '../../models/radio_station.dart';

class RegionListScreen extends StatefulWidget {
  RegionListScreen() {
    // exportData();
  }

  @override
  _RegionListScreenState createState() => _RegionListScreenState();
}

class _RegionListScreenState extends State<RegionListScreen> {
  final _searchController = TextEditingController();

  Map<dynamic, List<RadioStation>> groupedData;

  _performSearch() {
    print('${_searchController.text}');
    if (_searchController.text.isNotEmpty) {
      setState(() {
        /* _radioStationData = copy
            .where((element) => element.name.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ))
            .toList();
        print('${_radioStationData.length}'); */
      });
    } else
      setState(() {
        /*  _radioStationData = copy;
        print('${_radioStationData.length}'); */
      });
  }

  void selectRegion(
      BuildContext context, String regionName, List<RadioStation> stations) {
    print('Stations data == $stations');
    Navigator.of(context).pushNamed(ROUTE_STATION_LIST_SCREEN,
        arguments: {'stations': stations, 'region': regionName});
  }

  Widget _buildRegionItem(String regionName, List<RadioStation> stations) {
    return InkWell(
      onTap: () => selectRegion(context, regionName, stations),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Text(
          regionName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.w800, fontSize: 15, color: Colors.black87),
        ),
        decoration: BoxDecoration(
          gradient: linearGradient,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget buildGridView(
      BuildContext context, List<RadioStation> groupedStations) {
    groupedData = groupBy(groupedStations, (e) => e.region);

    print(groupedData.length);

    return Expanded(
      child: GridView(
        padding: const EdgeInsets.all(paddingNormal),
        children: groupedData.keys
            .map(
                (e) => _buildRegionItem(e.toString().titleCase, groupedData[e]))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          childAspectRatio: 1.2,
          crossAxisSpacing: paddingNormal,
          mainAxisSpacing: paddingNormal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          color: Colors.white,
          child: Column(
            children: [
              CustomAppBar(title: 'Regions', isHomeScreen: true),
              SizedBox(height: spacingNormal),
              SearchView(_searchController),
              SizedBox(height: spacingNormal),
            ],
          ),
        ),

        StreamBuilder(
          stream: Firestore.instance.collection('station_database').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            return buildGridView(
                context,
                (snapshot.data.documents as List)
                    .map((e) => RadioStation.fromJson(e.data))
                    .toList());
          },
        )

        //buildGridView(context, snapshots),
      ]),
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
}
