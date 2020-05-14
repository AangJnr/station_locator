import 'package:flutter/material.dart';

class RadioStation {
  final String name;
  final String frequency;
  final double lat;
  final double lng;

  RadioStation(
      {@required this.name, @required this.frequency, this.lat, this.lng});

  factory RadioStation.fromJson(dynamic json) {
    return RadioStation(
      name: json['stationname'],
      frequency: json['frequency'],
      lat: json['lat'] != null ? json['lat'].toDouble() : 0.0,
      lng: json['lng'] != null ? json['lng'].toDouble() : 0.0,
    );
  }

  String richLocationString() {
    return (lat == 0.0 && lng == 0.0)
        ? '--'
        : '${lat.toStringAsPrecision(4)}, ${lng.toStringAsPrecision(4)}';
  }
}
