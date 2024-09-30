import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Models/Document.dart';

class DocumentServices {

  Future<List<Document>> documentsByUserId(int userId) async {
    final url = Uri.parse('$apiURL/api/Global/documentList?userId=$userId');
    List<Document> documents = [];

    print("..............................url..................................");
    print(url);

    try {
      final response = await http.get(url);
      print("............................response....................................");
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        print(".......................data.........................................");
        print(data);

        for (int i = 0; i < data.length; i++) {
          Document document = Document(
            documentId: data[i]['documentId'],
            documentTitle: data[i]['documentTitle'],
            documentDescription: data[i]['documentDescription'],
            docType: data[i]['docType'],
            mainDocument: data[i]['mainDocument'],
            fileType: data[i]['fileType'],
            fileDate: data[i]['fileDate'],
          );
          documents.add(document);
        }
      } else {}
    } catch (e) {}

    return documents;
  }
}
