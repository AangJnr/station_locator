import 'package:recase/recase.dart';

import 'contact_address.dart';
import 'equiptment_info.dart';
import 'site_coordinates.dart';
import 'studio_transmitter_link.dart';

class RadioStation {
  final String companyName;
  final String tradeName;
  final String dateOfFirstAuthorisation;
  final String dateOfRenewal;
  final String assignedFrequency;
  final String onAirStatus;
  final String typeOfStation;
  final String callSign;
  final String location;
  final String locationClassification;
  final String locationOfTransmissionSystem;
  final String dateOfChangetransferByCompany;
  final String dateOfApprovalOfChangeByNca;

  final String coverageKm;
  final String antennaHeightM;
  final String antennaGainDb;
  final String powerToAntennaW;
  final String region;
  final String remarks;

//Physical Address
  final ContactAddress contactAddress;
//SiteCoordinates
  final SiteCoordinates siteCoordinates;
//Equipment Information
  final EquipmentInfo equipmentInformation;
  final StudioTransmitterLink studioTransmitterLink;

  RadioStation({
    this.antennaGainDb,
    this.antennaHeightM,
    this.assignedFrequency,
    this.callSign,
    this.companyName,
    this.contactAddress,
    this.coverageKm,
    this.dateOfApprovalOfChangeByNca,
    this.dateOfChangetransferByCompany,
    this.dateOfFirstAuthorisation,
    this.dateOfRenewal,
    this.equipmentInformation,
    this.location,
    this.locationClassification,
    this.locationOfTransmissionSystem,
    this.onAirStatus,
    this.powerToAntennaW,
    this.siteCoordinates,
    this.studioTransmitterLink,
    this.tradeName,
    this.typeOfStation,
    this.region,
    this.remarks,
  });

  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      antennaGainDb: json['antennaGainDb'].toString(),
      antennaHeightM: json['antennaHeightM'].toString(),
      assignedFrequency: json['assignedFrequency'].toString(),
      callSign: json['callSign'],
      companyName: json['companyName'],
      contactAddress: ContactAddress.fromJson(json),
      coverageKm: json['coverageKm'].toString(),
      dateOfApprovalOfChangeByNca: json['dateOfApprovalOfChangeByNca'],
      dateOfChangetransferByCompany: json['dateOfChangetransferByCompany'],
      dateOfFirstAuthorisation: json['dateOfFirstAuthorisation'],
      dateOfRenewal: json['dateOfRenewal'].toString(),
      equipmentInformation: EquipmentInfo.fromJson(json),
      location: json['location'],
      locationClassification: json['locationClassification'],
      locationOfTransmissionSystem: json['locationOfTransmissionSystem'],
      onAirStatus: json['onAirStatus'],
      powerToAntennaW: json['powerToAntennaW'].toString(),
      remarks: json['remarks'],
      siteCoordinates: SiteCoordinates.fromJson(json),
      studioTransmitterLink: StudioTransmitterLink.fromJson(json),
      tradeName: json['tradeName'],
      typeOfStation: json['typeOfStation'],
      region: json['region'],
    );
  }

  bool onAir() {
    return onAirStatus.toLowerCase().trim() == 'on air';
  }

  Map<String, dynamic> toMap() {
    //remove side coordinates data
    Map<String, dynamic> map = {
      'tradeName': tradeName,
      'companyName': companyName,
      'coverageKm': coverageKm,
      'region': region,
      'location': location,
      'locationClassification': locationClassification,
      'locationOfTransmissionSystem': locationOfTransmissionSystem,
      'typeOfStation': typeOfStation,
      'onAirStatus': onAirStatus,
      'powerToAntennaW': powerToAntennaW,
      'antennaGainDb': antennaGainDb,
      'antennaHeightM': antennaHeightM,
      'assignedFrequency': assignedFrequency,
      'callSign': callSign,
      'dateOfApprovalOfChangeByNca': dateOfApprovalOfChangeByNca,
      'dateOfChangetransferByCompany': dateOfChangetransferByCompany,
      'dateOfFirstAuthorisation': dateOfFirstAuthorisation,
      'dateOfRenewal': dateOfRenewal,
      'remarks': remarks,
    };
    return (map);
  }
}
