import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Components/HeadingText.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  File? image;
  final picker = ImagePicker();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeadingText(
          text: "Upload File",
          textColor: textColorDark,
          alignment: TextAlign.start,
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await pickImage();
              if (image != null) {
                final resizedImage = await resizeImage(image!);
                await createPdf(resizedImage);
              }
            },
            child: Text('Pick Image and Create PDF'),
          ),
        ],
      ),
    );
  }

  Future<File> resizeImage(File imageFile) async {
    final img.Image originalImage =
        img.decodeImage(await imageFile.readAsBytes())!;
    final img.Image resizedImage = img.copyResize(
      originalImage,
      width: (originalImage.width / 2).round(),
      height: (originalImage.height / 2).round(),
    );
    final Directory tempDir = await getTemporaryDirectory();
    final String resizedImagePath =
        path.join(tempDir.path, 'resized_image.jpg');
    final File resizedImageFile = File(resizedImagePath)
      ..writeAsBytesSync(img.encodeJpg(resizedImage));
    return resizedImageFile;
  }

  Future<void> createPdf(File imageFile) async {
    final pw.Document pdf = pw.Document();
    final image = pw.MemoryImage(imageFile.readAsBytesSync());
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(image),
          );
        },
      ),
    );

    final Directory tempDir = await getTemporaryDirectory();
    final String pdfPath = path.join(tempDir.path, 'uploadImages.pdf');
    final File pdfFile = File(pdfPath);
    await pdfFile.writeAsBytes(await pdf.save());
    print('PDF saved at: $pdfPath');
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source:  ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<String> convertPdfToBase64(File pdfFile) async {
    final bytes = await pdfFile.readAsBytes();
    return base64Encode(bytes);
  }
}
