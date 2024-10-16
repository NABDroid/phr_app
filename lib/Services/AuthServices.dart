import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Models/HistoryTitles.dart';
import 'package:phr_app/Models/MedicalHistory.dart';
import 'package:phr_app/Models/UserInfo.dart';
import '../Models/RegisterDTO.dart';

class AuthServices {
  Future<List<HistoryTitle>> fetchHistoryTitles() async {
    final url = Uri.parse('$apiURL/api/Patient/historyTitles');
    List<HistoryTitle> titles = [];

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        for (int i = 0; i < data.length; i++) {
          HistoryTitle title = HistoryTitle(
              titleId: data[i]['titleId'],
              title: data[i]['title'],
              isChecked: false);
          titles.add(title);
        }
      } else {}
    } catch (e) {}

    return titles;
  }

  Future<List<HistoryTitle>> getUserMedicalHistory() async {
    final url = Uri.parse(
        '$apiURL/api/Patient/getUserMedicalHistory?userId=${currentUserInfo.userId}');
    List<HistoryTitle> titles = [];

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        for (int i = 0; i < data.length; i++) {
          HistoryTitle title = HistoryTitle(
              historyId: data[i]['historyId'],
              titleId: data[i]['titleId'],
              title: data[i]['title'],
              isChecked: data[i]['isTrue']);
          titles.add(title);
        }
      } else {}
    } catch (e) {
      print(e);
    }

    return titles;
  }

  Future<UserInfo> userLogin(String email, String password) async {
    UserInfo userInfo = UserInfo(userId: 0, isActive: false);

    final url =
        Uri.parse('$apiURL/api/Auth/login?userName=$email&password=$password');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        if (message == "Login successful") {
          userInfo = UserInfo(
              userId: jsonResponse['data']['userId'],
              fullName: jsonResponse['data']['fullName'],
              emailAddress: jsonResponse['data']['emailAddress'],
              contactNo: jsonResponse['data']['contctNo'],
              address: jsonResponse['data']['address'],
              gender:
                  (jsonResponse['data']['genderId'] == 1) ? "Male" : "Female",
              dateOfBirth: DateTime.parse(jsonResponse['data']['dateOfBirth']),
              bloodGroup: jsonResponse['data']['bloodGroup'],
              fatherName: jsonResponse['data']['fatherName'],
              motherName: jsonResponse['data']['motherName'],
              identificationNo: jsonResponse['data']['identificationNo'],
              identificationTypeId:
                  jsonResponse['data']['identificationTypeId'].toString(),
              userType: jsonResponse['data']['userType'],
              registrationTime:
                  DateTime.parse(jsonResponse['data']['registrationTime']),
              isActive: jsonResponse['data']['isActive'],
              firstSos: jsonResponse['data']['firstSos'],
              secondSos: jsonResponse['data']['secondSos'],
              thirdSos: jsonResponse['data']['thirdSos'],
              inactiveTime: jsonResponse['data']['inactiveTime']);
          currentUserInfo = userInfo;
          return userInfo;
        }
      } else {}
    } catch (e) {}

    return userInfo;
  }

  Future<UserInfo> userRegister(RegisterDTO registerDto) async {
    UserInfo userInfo = UserInfo(userId: 0, isActive: false);

    final url = Uri.parse('$apiURL/api/auth/register');
    try {
      final body = jsonEncode(registerDto.toJson());

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        if (message == "Registration successful") {
          userInfo = UserInfo(
              userId: jsonResponse['data']['userId'],
              fullName: jsonResponse['data']['fullName'],
              emailAddress: jsonResponse['data']['emailAddress'],
              contactNo: jsonResponse['data']['contactNo'],
              address: jsonResponse['data']['address'],
              gender:
                  (jsonResponse['data']['genderId'] == 1) ? "Male" : "Female",
              dateOfBirth: DateTime.parse(jsonResponse['data']['dateOfBirth']),
              bloodGroup: jsonResponse['data']['bloodGroup'],
              fatherName: jsonResponse['data']['fatherName'],
              motherName: jsonResponse['data']['motherName'],
              identificationNo: jsonResponse['data']['identificationNo'],
              identificationTypeId: jsonResponse['data']
                  ['identificationTypeId'],
              userType: (jsonResponse['data']['userType'] == 1)
                  ? "Patient"
                  : "Doctor",
              registrationTime:
                  DateTime.parse(jsonResponse['data']['registrationTime']),
              isActive: jsonResponse['data']['isActive'],
              inactiveTime: jsonResponse['data']['inactiveTime']);
          currentUserInfo = userInfo;

          return userInfo;
        }
      } else {}
    } catch (e) {}

    return userInfo;
  }

  Future<bool> submitUserHistory(List<MedicalHistory> medicalHistories) async {
    final url = Uri.parse('$apiURL/api/Patient/submitPatientHistory');
    try {
      final body =
          jsonEncode(medicalHistories.map((user) => user.toJson()).toList());

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        if (message == "added history!") {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  Future<UserInfo> updateProfile(
      String? name,
      String? email,
      String? contactNo,
      String? address,
      String? firstSOS,
      String? secondSOS,
      String? thirdSOS,
      String? dateOfBirth) async {
    UserInfo userInfo = UserInfo(userId: 0, isActive: false);

    final url = Uri.parse(
        '$apiURL/api/Patient/updateProfile?userId=${currentUserInfo.userId}&name=$name&email=$email&contactNo=$contactNo&address=$address&firstSOS=$firstSOS&secondSOS=$secondSOS&thirdSOS=$thirdSOS&dateOfBirth=$dateOfBirth');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        if (message == "Updated profile") {
          userInfo = UserInfo(
              userId: jsonResponse['data']['userId'],
              fullName: jsonResponse['data']['fullName'],
              emailAddress: jsonResponse['data']['emailAddress'],
              contactNo: jsonResponse['data']['contctNo'],
              address: jsonResponse['data']['address'],
              gender:
                  (jsonResponse['data']['genderId'] == 1) ? "Male" : "Female",
              dateOfBirth: DateTime.parse(jsonResponse['data']['dateOfBirth']),
              bloodGroup: jsonResponse['data']['bloodGroup'],
              fatherName: jsonResponse['data']['fatherName'],
              motherName: jsonResponse['data']['motherName'],
              identificationNo: jsonResponse['data']['identificationNo'],
              identificationTypeId:
                  jsonResponse['data']['identificationTypeId'].toString(),
              userType: jsonResponse['data']['userType'],
              registrationTime:
                  DateTime.parse(jsonResponse['data']['registrationTime']),
              isActive: jsonResponse['data']['isActive'],
              firstSos: jsonResponse['data']['firstSos'],
              secondSos: jsonResponse['data']['secondSos'],
              thirdSos: jsonResponse['data']['thirdSos'],
              inactiveTime: jsonResponse['data']['inactiveTime']);
          currentUserInfo = userInfo;
          return userInfo;
        }
      } else {}
    } catch (e) {}

    return userInfo;
  }
}
