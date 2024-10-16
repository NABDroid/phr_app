import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import '../../Components/Global.dart';
import '../../Components/HeadingText.dart';
import '../../Models/Document.dart';
import '../../Services/DocumentsServices.dart';

class FilePreview extends StatefulWidget {
  const FilePreview({super.key, required this.documentId});

  final int documentId;

  @override
  State<FilePreview> createState() => _FilePreviewState();
}

class _FilePreviewState extends State<FilePreview> {
  DocumentServices documentServices = DocumentServices();
  late Document document;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeadingText(
            text: "Document view",
            textColor: textColorLite,
            alignment: TextAlign.center),
        backgroundColor: themeColorDark,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          FutureBuilder<Document>(
            future: documentServices.getDocumentById(widget.documentId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('No data available'));
              }

              document = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeadingText(
                        text: document.documentTitle!,
                        textColor: textColorDark,
                        alignment: TextAlign.center),
                    DetailsText(
                        text: document.documentDescription!,
                        textColor: textColorDark,
                        alignment: TextAlign.start),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: PDFView(
                      filePath: document.file!.path,
                    )),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.download_rounded,
          size: 30,
          color: textColorLite,
        ),
        onPressed: () {
          downloadThePDF();
        },
        backgroundColor: themeColorDark,
      ),
    );
  }

  Future<void> downloadThePDF() async {
    try {
      if (document == null || document.file != null) {
        File pdfFile = document.file!;
        String fileName = document.documentTitle!;
        Directory? directory = await getExternalStorageDirectory();
        // String newPath = directory!.path;
        String newPath = '/storage/emulated/0/Download';
        File newFile = File('$newPath/$fileName.pdf');
        await pdfFile.copy(newFile.path);

        Fluttertoast.showToast(
            msg: 'PDF saved to downloads',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: 'No file found',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error saving file: $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
