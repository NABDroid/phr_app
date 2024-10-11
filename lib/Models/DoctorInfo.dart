class DoctorInfo {
  final int doctorId;
  final int hospitalId;
  final String doctorName;
  final String doctorsGender;
  final String achievedDegrees;
  final String registrationNo;
  final double latitude;
  final double longitude;
  final String chamberAddress;
  final String universities;
  final String workTimes;
  final bool isActive;

  DoctorInfo({
    required this.doctorId,
    required this.hospitalId,
    required this.doctorName,
    required this.doctorsGender,
    required this.achievedDegrees,
    required this.registrationNo,
    required this.latitude,
    required this.longitude,
    required this.chamberAddress,
    required this.universities,
    required this.workTimes,
    required this.isActive,
  });

  factory DoctorInfo.fromJson(Map<String, dynamic> json) {
    return DoctorInfo(
      doctorId: json['doctorId'],
      hospitalId: json['hospitalId'],
      doctorName: json['doctorName'],
      doctorsGender: json['doctorsGender'],
      achievedDegrees: json['achievedDegrees'],
      registrationNo: json['registrationNo'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      chamberAddress: json['chamberAddress'],
      universities: json['universities'],
      workTimes: json['workTimes'],
      isActive: json['isActive'],
    );
  }
}
