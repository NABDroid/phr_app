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

  Future<UserInfo> userLogin(String email, String password) async {
    UserInfo userInfo = UserInfo(userId: 0, isActive: false);

    final url =
        Uri.parse('$apiURL/api/Auth/login?userName=$email&password=$password');
    try {
      print("===========================================================================");
      print(url);
      final response = await http.get(url);
      print("===========================================================================");
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        if (message == "Login successful") {
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
              identificationTypeId: jsonResponse['data']['identificationTypeId'].toString(),
              userType: jsonResponse['data']['userType'],
              registrationTime:
                  DateTime.parse(jsonResponse['data']['registrationTime']),
              isActive: jsonResponse['data']['isActive'],
              inactiveTime: jsonResponse['data']['inactiveTime']);
          currentUserInfo = userInfo;
          return userInfo;
        }
      } else {

      }
    } catch (e) {
      print(e);
    }

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
              userType: (jsonResponse['data']['userType'] == 1)?"Patient":"Doctor",
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
}
