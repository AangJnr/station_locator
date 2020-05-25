import 'package:station_locator/models/custom_location.dart';

class StudioTransmitterLink extends CustomLocation{
  final String stlUse;
  final String assignedLinkFrequencyStl;
  final String studioLatitude;
  final String studioLongitude;
  final String studioAltitude;
  final String stlMake;
  final String stlModel;
  final String obUse;
  final String assignedLinkFrequencyOb;

  StudioTransmitterLink(
      {this.assignedLinkFrequencyOb,
      this.assignedLinkFrequencyStl,
      this.obUse,
      this.stlMake,
      this.stlModel,
      this.stlUse,
      this.studioAltitude,
      this.studioLatitude,
      this.studioLongitude});

  factory StudioTransmitterLink.fromJson(dynamic json) {
    return new StudioTransmitterLink(
        assignedLinkFrequencyOb: json['assignedLinkFrequencyOb'].toString(),
        assignedLinkFrequencyStl: json['assignedLinkFrequencyStl'].toString(),
        obUse: json['obUse'],
        stlMake: json['stlMake'],
        stlModel: json['stlModel'],
        stlUse: json['stlUse'],
        studioAltitude: json['studioAltitude'].toString(),
        studioLatitude: json['studioLatitude'],
        studioLongitude: json['studioLongitude']);
  }

  Map<String, dynamic> toMap() {
    //remove side coordinates data
    Map<String, dynamic> map = {
      'assignedLinkFrequencyOb': assignedLinkFrequencyOb,
      'assignedLinkFrequencyStl': assignedLinkFrequencyStl,
      'obUse': obUse,
      'stlMake': stlMake,
      'stlModel': stlModel,
      'stlUse': stlUse,
      'studioAltitude': studioAltitude,
      'studioLatitude': studioLatitude,
      'studioLongitude': studioLongitude,
    };
    return (map);
  }

  List<double> location() {
    return getLocation(studioLatitude, studioLongitude);
  }
}
