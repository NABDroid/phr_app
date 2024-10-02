import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../../Components/Global.dart';
import '../../Components/HeadingText.dart';
import '../../Models/Document.dart';
import '../../Services/DocumentsServices.dart';

class FilePreview extends StatelessWidget {
  const FilePreview({super.key, required this.documentId});

  final int documentId;

  @override
  Widget build(BuildContext context) {
    DocumentServices? documentServices = DocumentServices();
    return Scaffold(
      appBar: AppBar(
        title: HeadingText(text: "Document view", textColor: textColorDark, alignment: TextAlign.center),
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
            future: documentServices.getDocumentById(documentId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('No data available'));
              }

              Document document = snapshot.data!;
              // File downloadedFile = document.file!;
              //
              // print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
              // print(downloadedFile.path);
              // print(downloadedFile);

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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(color: themeColorLite, height: 1,),
                    ),
                    Expanded(child: PDFView(filePath: document.file!.path,)),

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
        onPressed: () {},
        backgroundColor: themeColorDark,
      ),
    );
  }
}
