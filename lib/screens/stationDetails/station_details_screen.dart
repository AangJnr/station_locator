import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:recase_string_extension/recase.dart';

import '../../configurations/themeData.dart';
import '../../models/radio_station.dart';
import '../../widgets/custom_appbar.dart';
import '../../common_methods.dart';

class StationDetailScreen extends StatelessWidget {
  Widget _buildMapView(
      BuildContext context, String title, double lat, double lng) {
    LatLng latlng = LatLng(lat, lng);

    final CameraPosition cameraPosition =
        CameraPosition(target: latlng, zoom: 15);

    return Container(
      width: double.infinity,
      height: 150,
      child: GoogleMap(
        compassEnabled: false,
        mapToolbarEnabled: false,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        scrollGesturesEnabled: false,
        onTap: (context) => Common.openMaps(
          context,
          title,
          lat,
          lng,
        ),
        markers: {
          Marker(
            position: latlng,
            markerId: MarkerId(
              latlng.hashCode.toString(),
            ),
          )
        },
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: cameraPosition,
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(paddingHalf),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: spacingHalf,
          ),
          Flexible(
            child: Text(
              value.trim(),
              softWrap: true,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSliverBoxAdapter(String subTitle) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
            left: paddingNormal,
            right: paddingNormal,
            top: paddingNormal * 2,
            bottom: paddingNormal),
        child: Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: colors.first,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  SliverGrid _buildSliverGrid(
    BuildContext context,
    Map<String, dynamic> map,
    bool isLandscape,
  ) {
    return SliverGrid.count(
      childAspectRatio: 2,
      crossAxisCount: isLandscape ? 4 : 2,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      children: map.entries
          .map(
            (e) => _buildGridItem(context, e.key.titleCase, e.value.toString()),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    RadioStation station = (ModalRoute.of(context).settings.arguments
        as Map)['station'] as RadioStation;

    var studioLocation = station.siteCoordinates.location();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(children: [
          CustomAppBar(title: station.tradeName.titleCase),
          SizedBox(height: spacingNormal),
          (!isLandscape && studioLocation != null)
              ? _buildMapView(context, station.tradeName, studioLocation[0],
                  studioLocation[1])
              : SizedBox(height: 0),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: paddingQuarter,
              ),
              child: CustomScrollView(slivers: [
                //Main details
                _buildSliverBoxAdapter('Main Details'),
                _buildSliverGrid(context, station.toMap(), isLandscape),

                _buildSliverBoxAdapter('Contact Address'),
                _buildSliverGrid(
                    context, station.contactAddress.toMap(), isLandscape),
                _buildSliverBoxAdapter('Site Coordinates'),
                _buildSliverGrid(
                    context, station.siteCoordinates.toMap(), isLandscape),

                _buildSliverBoxAdapter('Eqiopment Information'),
                _buildSliverGrid(
                    context, station.equipmentInformation.toMap(), isLandscape),

                _buildSliverBoxAdapter('Studio Transmitter Link'),
                _buildSliverGrid(
                    context, station.studioTransmitterLink.toMap(), isLandscape)
              ]),
            ),
          ),
          SizedBox(height: spacingNormal * 2),
        ]),
      ),
    );
  }
}
