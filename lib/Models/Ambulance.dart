class Ambulance {
  final int ambulanceId;
  final int hospitalId;
  final String ambulanceTitle;
  final String ambulanceDetails;
  final String driverContact;
  final bool isActive;

  Ambulance({
    required this.ambulanceId,
    required this.hospitalId,
    required this.ambulanceTitle,
    required this.ambulanceDetails,
    required this.driverContact,
    required this.isActive,
  });

  factory Ambulance.fromJson(Map<String, dynamic> json) {
    return Ambulance(
      ambulanceId: json['ambulanceId'],
      hospitalId: json['hospitalId'],
      ambulanceTitle: json['ambulanceTitle'],
      ambulanceDetails: json['ambulanceDetails'],
      driverContact: json['driverContact'],
      isActive: json['isActive'],
    );
  }
}
