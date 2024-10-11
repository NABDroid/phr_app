class UserInfo {
  int userId;
  String? fullName, emailAddress, contactNo, address, gender, bloodGroup, fatherName, motherName, identificationNo, identificationTypeId, userType, firstSos, secondSos, thirdSos;
  DateTime? dateOfBirth, registrationTime, inactiveTime;
  bool? isActive;

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
    this.isActive,
    this.inactiveTime,
    this.firstSos,
    this.secondSos,
    this.thirdSos,
  });
}



