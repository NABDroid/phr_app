import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phr_app/Components/Global.dart';

import '../Models/Ambulance.dart';
import '../Models/DoctorInfo.dart';
import '../Models/Hospital.dart';
import '../Models/MedicalHistory.dart';

class HospitalServices {

  Future<List<Hospital>> fetchHospitals(int divisionId, int districtId, int unionId) async {
    final response = await http.get(
        Uri.parse('$apiURL/api/Global/allHospitals?divisionId=$divisionId&districtId=$districtId&unionId=$unionId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> data = jsonData['data'];
      return data.map((hospital) => Hospital.fromJson(hospital)).toList();
    } else {
      throw Exception('Failed to load hospitals');
    }
  }


  Future<List<Ambulance>> fetchAmbulances(int hospitalId) async {
    final response = await http.get(Uri.parse('$apiURL/api/Global/ambulances?hospitalId=$hospitalId'));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if(responseData['data'] != null){
        List<dynamic> data = responseData['data'];
        return data.map((ambulance) => Ambulance.fromJson(ambulance)).toList();
      } else {
        List<Ambulance> ambulances = [];
        return  ambulances;
      }
    } else {
      List<Ambulance> ambulances = [];
      return  ambulances;
    }
  }

  Future<List<DoctorInfo>> fetchDoctors(int hospitalId) async {
    final url = Uri.parse('$apiURL/api/Global/doctors?hospitalId=$hospitalId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data.map((doctor) => DoctorInfo.fromJson(doctor)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  Future<bool> updatePatientHistory(List<MedicalHistory> medicalHistories) async {
    final url = Uri.parse('$apiURL/api/Patient/updatePatientHistory');
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
        if (message == "updated") {
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
