import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Models/HistoryTitles.dart';

class RegistrationServices {
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
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }

    return titles;
  }

  Future<bool> register() async {
    final url = Uri.parse('$apiURL/api/auth/register');
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }

    return false;
  }
}
