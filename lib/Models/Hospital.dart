class Hospital {
  final int hospitalId;
  final String hospitalName;
  final String hospitalAddress;
  final int noOfSeat;
  final int bookedSeat;
  final String contactNo;
  final bool isActive;

  Hospital({
    required this.hospitalId,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.noOfSeat,
    required this.bookedSeat,
    required this.contactNo,
    required this.isActive,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      hospitalId: json['hospitalId'],
      hospitalName: json['hospitalName'],
      hospitalAddress: json['hospitalAddress'],
      noOfSeat: json['noOfSeat'],
      bookedSeat: json['bookedSeat'],
      contactNo: json['contactNo'],
      isActive: json['isActive'],
    );
  }
}