import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:station_locator/data.dart';

void exportData() async {
  final firestoreInstance = Firestore.instance;

  print('Start export data');

  Map<String, dynamic> addEquipmentInfoMap(Map<String, dynamic> stationData) {
    Map equipmentInformation = Map();
    equipmentInformation.putIfAbsent(
        'transmitterMake', () => stationData['transmitterMake']);
    stationData.remove('transmitterMake');

    equipmentInformation.putIfAbsent('modelNo', () => stationData['modelNo']);
    stationData.remove('modelNo');

    equipmentInformation.putIfAbsent(
        'maxOutputPowerw', () => stationData['maxOutputPowerw']);
    stationData.remove('maxOutputPowerw');

    equipmentInformation.putIfAbsent(
        'antennaMake', () => stationData['antennaMake']);
    stationData.remove('antennaMake');

    equipmentInformation.putIfAbsent(
        'antennaModel', () => stationData['antennaModel']);
    stationData.remove('antennaModel');

    equipmentInformation.putIfAbsent('diameter', () => stationData['diameter']);
    stationData.remove('diameter');

    equipmentInformation.putIfAbsent('lossmDb', () => stationData['lossmDb']);
    stationData.remove('lossmDb');

    equipmentInformation.putIfAbsent(
        'cableLengthm', () => stationData['cableLengthm']);
    stationData.remove('cableLengthm');

    return stationData;
  }

  Map<String, dynamic> addSiteCoordinatesMap(Map<String, dynamic> stationData) {
    Map map = Map();
    map.putIfAbsent('latitude', () => stationData['latitude']);
    stationData.remove('latitude');

    map.putIfAbsent('longitude', () => stationData['longitude']);
    stationData.remove('longitude');

    map.putIfAbsent('altitudeM', () => stationData['altitudeM']);
    stationData.remove('altitudeM');

    return stationData;
  }

  Map<String, dynamic> contactAddress(Map<String, dynamic> stationData) {
    Map map = Map();
    map.putIfAbsent('physicalAddress', () => stationData['physicalAddress']);
    stationData.remove('physicalAddress');

    map.putIfAbsent(
        'postalemailAddress', () => stationData['postalemailAddress']);
    stationData.remove('postalemailAddress');

    map.putIfAbsent('telephonefax', () => stationData['telephonefax']);
    stationData.remove('telephonefax');

    return stationData;
  }

  Map<String, dynamic> studioTransmitterLink(Map<String, dynamic> stationData) {
    Map map = Map();
    map.putIfAbsent('stlUse', () => stationData['stlUse']);
    stationData.remove('stlUse');

    map.putIfAbsent('assignedLinkFrequencyStl',
        () => stationData['assignedLinkFrequencyStl']);
    stationData.remove('assignedLinkFrequencyStl');

    map.putIfAbsent('studioLatitude', () => stationData['studioLatitude']);
    stationData.remove('studioLatitude');

    map.putIfAbsent('studioLongitude', () => stationData['studioLongitude']);
    stationData.remove('studioLongitude');

    map.putIfAbsent('studioAltitude', () => stationData['studioAltitude']);
    stationData.remove('studioAltitude');

    map.putIfAbsent('stlMake', () => stationData['stlMake']);
    stationData.remove('stlMake');

    map.putIfAbsent('stlModel', () => stationData['stlModel']);
    stationData.remove('stlModel');

    map.putIfAbsent('obUse', () => stationData['obUse']);
    stationData.remove('obUse');

    map.putIfAbsent('assignedLinkFrequencyOb',
        () => stationData['assignedLinkFrequencyOb']);
    stationData.remove('assignedLinkFrequencyOb');

    return stationData;
  }

  UPDATED_DATA.forEach((object) {

    object.forEach((regionName, listOfStations) {
       listOfStations.forEach((station)   {
        var stationData = Map<String, dynamic>.from(station);
        stationData.putIfAbsent('region', () => regionName);


       firestoreInstance.collection("station_database").add(stationData);


      });
     });
   });

    print('Done exporting data!');
}
