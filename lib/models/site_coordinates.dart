import 'package:station_locator/models/custom_location.dart';

class SiteCoordinates extends CustomLocation {
  final String latitude;
  final String longitude;
  final String altitudeM;

  SiteCoordinates({this.altitudeM, this.latitude, this.longitude});

  factory SiteCoordinates.fromJson(dynamic json) {
    return SiteCoordinates(
        latitude: json['latitude'],
        longitude: json['longitude'],
        altitudeM: json['altitudeM'].toString());
  }

  Map<String, dynamic> toMap() {
    //remove side coordinates data
    Map<String, dynamic> map = {
      'latitude': latitude,
      'longitude': longitude,
      'altitudeM': altitudeM
    };
    return (map);
  }

  List<double> location() {
    return getLocation(latitude, longitude);
  }
}
