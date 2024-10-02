import 'dart:io';

class Document {
  final int? documentId;
  final String? documentTitle, documentDescription, docType, mainDocument, fileType, fileDate ;
  final File? file;

  Document({this.documentId, this.documentTitle, this.documentDescription,
    this.docType, this.mainDocument, this.fileType, this.fileDate, this.file});
}
