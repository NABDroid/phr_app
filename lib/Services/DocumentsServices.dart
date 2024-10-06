import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Models/Document.dart';

class DocumentServices {

  Future<List<Document>> documentListOfUser(int userId) async {
    final url = Uri.parse('$apiURL/api/Global/documentList?userId=$userId');
    List<Document> documents = [];

    // print("..............................url..................................");
    // print(url);

    try {
      final response = await http.get(url);
      // print("............................response....................................");
      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        // print(".......................data.........................................");
        // print(data);

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

  Future<Document> getDocumentById(int documentId) async {
    final url = Uri.parse('$apiURL/api/Global/getDocumentById?documentId=$documentId');
    Document document = Document();

    // print("..............................url..................................");
    // print(url);

    try {
      final response = await http.get(url);
      // print("............................response....................................");
      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'];
        // print(".......................data.........................................");
        // print(data);


        final String dir = (await getTemporaryDirectory()).path;
        final String path = '$dir/temp.pdf';
        final File file = File(path);


        try{
          final Uint8List bytes = base64.decode(data['mainDocument']);
          print("=========================== bytes");
          print(bytes);
          await file.writeAsBytes(bytes);
          print("===========================");
          print(file.path);
          print(file);
        } catch (e) {
          print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
          print(e);

        }






        document = Document(
          documentId: data['documentId'],
          documentTitle: data['documentTitle'],
          documentDescription: data['documentDescription'],
          docType: data['docType'],
          mainDocument: data['mainDocument'],
          fileType: data['fileType'],
          fileDate: data['fileDate'],
          file: file,
        );




      } else {}
    } catch (e) {}

    return document;
  }

  Future<String> uploadDocument(File pdfFile, int userId, String fileName, String description, String fileType, int docTypeId) async {
    String base64Pdf = await convertPdfToBase64(pdfFile);

    List<Map<String, dynamic>> data = [
      {
        "userId": userId,
        "fileName": fileName,
        "fileDescription": description,
        "base64File": base64Pdf,
        "fileType": fileType,
        "docTypeId": docTypeId,
      }
    ];
    var response = await http.post(
      Uri.parse('$apiURL/api/Global/uploadDocument'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return 'Upload successful';
    } else {
      return 'Failed to upload: ${response.statusCode}';
    }
  }

  Future<String> convertPdfToBase64(File pdfFile) async {
    final bytes = await pdfFile.readAsBytes();
    return base64Encode(bytes);
  }




}
