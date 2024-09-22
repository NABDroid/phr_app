import 'dart:convert';

import 'package:http/http.dart' as http;

class RegistrationServices {


  Future<void> fetchHistoryTitles() async {
    final url = Uri.parse('http://localhost:83/api/Patient/historyTitles');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        print(data);


      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }








}