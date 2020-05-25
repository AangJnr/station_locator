class ContactAddress {
  final String physicalAddress;
  final String postalemailAddress;
  final String telephonefax;

  ContactAddress(
      {this.physicalAddress, this.postalemailAddress, this.telephonefax});

  factory ContactAddress.fromJson(dynamic json) {
    return ContactAddress(
        physicalAddress: json['physicalAddress'].toString(),
        postalemailAddress: json['postalemailAddress'].toString(),
        telephonefax: json['telephonefax'].toString());
  }

  Map<String, dynamic> toMap() {
    //remove side coordinates data
    Map<String, dynamic> map = {
      'physicalAddress': physicalAddress,
      'postalemailAddress': postalemailAddress,
      'telephonefax': telephonefax
    };
    return (map);
  }
}
