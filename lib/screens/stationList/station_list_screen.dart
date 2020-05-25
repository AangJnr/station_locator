import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recase_string_extension/recase.dart';

import '../../configurations/constants.dart';
import '../../models/radio_station.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/search_view.dart';
import '../../common_methods.dart';
import '../../configurations/themeData.dart';

class StationListScreen extends StatefulWidget {
  @override
  _StationListScreenState createState() => _StationListScreenState();
}

class _StationListScreenState extends State<StationListScreen> {
  final _searchController = TextEditingController();
  var _radioStationData;

  var selectedTag = 'name';

  final List<RadioStation> copy = List<RadioStation>();
  String regionName;
  bool hasVariableBeenInitialized = false;

  _StationListScreenState();

  _performSearch() {
    print('${_searchController.text}');
    setState(() {
      if (_searchController.text.isNotEmpty) {
        if (selectedTag.toLowerCase() == 'frequency')
          _radioStationData = copy
              .where(
                  (element) => element.assignedFrequency.toLowerCase().contains(
                        _searchController.text.toLowerCase(),
                      ))
              .toList();
        else
          _radioStationData = copy
              .where((element) => element.tradeName.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ))
              .toList();
      } else {
        _radioStationData = copy;
        print('${_radioStationData.length}');
      }
    });
  }

  void selectStation(BuildContext context, RadioStation station) {
    Navigator.of(context).pushNamed(ROUTE_STATION_DETAILS_SCREEN, arguments: {
      'station': station,
    });
  }

  Widget _buildListItem(BuildContext ctx, RadioStation station) {
    final List<double> transmitterLocation = station.siteCoordinates.location();
    final List<double> studioLocation =
        station.studioTransmitterLink.location();

    return InkWell(
      key: ValueKey(station.hashCode),
      onTap: () => selectStation(ctx, station),
      splashColor: linearGradient.colors.first.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: paddingNormal, vertical: paddingHalf),
        child: Row(children: [
          Container(
            alignment: Alignment.center,
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(paddingNormal),
            child: Text(
              station.tradeName.substring(0, 1),
              style: Theme.of(ctx)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            decoration: BoxDecoration(
              gradient: linearGradient,
              borderRadius: BorderRadius.circular(70),
            ),
          ),
          SizedBox(width: paddingNormal),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${station.tradeName.titleCase}',
                      style: Theme.of(ctx)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                    Container(
                      padding: EdgeInsets.all(spacingQuarter),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: (station.onAir() ? Colors.green : Colors.red),
                      ),
                      child: Text(
                        station.onAir() ? 'ON AIR' : 'NOT ON AIR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.offline_bolt,
                      size: 15,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      width: paddingQuarter,
                    ),
                    Text(
                      '${station.assignedFrequency}',
                      style: Theme.of(ctx).textTheme.subtitle1.copyWith(
                          fontSize: 13,
                          color: Colors.black54,
                          letterSpacing: 1),
                    ),
                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: Text(
                          station.location,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                    Row(
                      children: <Widget>[
                        if (studioLocation != null)
                          InkWell(
                            onTap: () => Common.openMaps(
                              ctx,
                              station.tradeName,
                              studioLocation[0],
                              studioLocation[1],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(paddingHalf),
                              child: Icon(
                                FontAwesomeIcons.locationArrow,
                                size: 18,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        SizedBox(width: spacingHalf),
                        if (transmitterLocation != null)
                          InkWell(
                            onTap: () => Common.openMaps(
                              ctx,
                              station.tradeName,
                              transmitterLocation[0],
                              transmitterLocation[1],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(paddingHalf),
                              child: Icon(
                                FontAwesomeIcons.broadcastTower,
                                size: 18,
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildTagItem(String tag) {
    return InkWell(
      onTap: () => {
        setState(() => {
          selectedTag = tag,
          _searchController.clear()
          })
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(spacingHalf),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: (tag.toLowerCase() == selectedTag.toLowerCase())
                ? colors.first
                : Colors.grey[400]),
        child: Text(
          tag,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.normal,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      children: [buildTagItem("Frequency"), buildTagItem("Name")],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!hasVariableBeenInitialized) {
      final routesArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      regionName = routesArgs['region'];
      _radioStationData = (routesArgs['stations'] as List<RadioStation>)
          .where((element) => element.tradeName.toLowerCase() != 'n/a')
          .toList();
      copy.addAll(_radioStationData);

      hasVariableBeenInitialized = true;
      print('Variable init complete.');
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: regionName),
              SizedBox(height: spacingNormal),
              SearchView(_searchController),
              Padding(
                padding: const EdgeInsets.all(paddingNormal),
                child: _buildTags(),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[300],
            ),
            itemBuilder: (ctx, index) =>
                _buildListItem(ctx, _radioStationData[index]),
            itemCount: _radioStationData.length,
          ),
        )
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
