class RegisterDTO {
  String fullName;
  String emailAddress;
  String contactNo;
  String address;
  int genderId;
  DateTime dateOfBirth;
  String bloodGroup;
  String identificationNo;
  String identificationTypeId;
  String password;

  RegisterDTO({
    required this.fullName,
    required this.emailAddress,
    required this.contactNo,
    required this.address,
    required this.genderId,
    required this.dateOfBirth,
    required this.bloodGroup,
    required this.identificationNo,
    required this.identificationTypeId,
    required this.password,
  });


  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'emailAddress': emailAddress,
      'contctNo': contactNo, // "contctNo" should match the original JSON key
      'address': address,
      'genderId': genderId,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'bloodGroup': bloodGroup,
      'identificationNo': identificationNo,
      'identificationTypeId': identificationTypeId,
      'password': password,
    };
  }
}
