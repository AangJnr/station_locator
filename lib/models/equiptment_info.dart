class EquipmentInfo {
  final String transmitterMake;
  final String modelNo;
  final String maxOutputPowerw;
  final String antennaMake;
  final String antennaModel;
  final String diameter;
  final String lossmDb;
  final String cableLengthm;

  EquipmentInfo(
      {this.antennaMake,
      this.antennaModel,
      this.cableLengthm,
      this.diameter,
      this.lossmDb,
      this.maxOutputPowerw,
      this.modelNo,
      this.transmitterMake});

  factory EquipmentInfo.fromJson(dynamic json) {
    return EquipmentInfo(
        antennaMake: json['antennaMake'].toString(),
        antennaModel: json['antennaModel'].toString(),
        cableLengthm: json['cableLengthm'].toString(),
        diameter: json['diameter'].toString(),
        lossmDb: json['lossmDb'].toString(),
        maxOutputPowerw: json['maxOutputPowerw'].toString(),
        modelNo: json['modelNo'].toString(),
        transmitterMake: json['transmitterMake']);
  }

  Map<String, dynamic> toMap() {
    //remove side coordinates data
    Map<String, dynamic> map = {
      'antennaMake': antennaMake,
      'antennaModel': antennaModel,
      'cableLengthm': cableLengthm,
      'diameter': diameter,
      'lossmDb': lossmDb,
      'maxOutputPowerw': maxOutputPowerw,
      'modelNo': modelNo,
      'transmitterMake': transmitterMake,
    };
    return (map);
  }
}
