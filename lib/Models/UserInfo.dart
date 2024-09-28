class UserInfo {
  int userId;
  String? fullName, emailAddress, contactNo, address, gender, bloodGroup, fatherName, motherName, identificationNo, identificationTypeId;
  DateTime? dateOfBirth, registrationTime, inactiveTime;
  int? userType;
  bool isActive;

  UserInfo({
    required this.userId,
    this.fullName,
    this.emailAddress,
    this.contactNo,
    this.address,
    this.gender,
    this.dateOfBirth,
    this.bloodGroup,
    this.fatherName,
    this.motherName,
    this.identificationNo,
    this.identificationTypeId,
    this.userType,
    this.registrationTime,
    required this.isActive,
    this.inactiveTime,
  });
}
