import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Components/HeadingText.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../../Services/DocumentsServices.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  final picker = ImagePicker();
  TextEditingController fileTitle = TextEditingController();
  TextEditingController fileDescription = TextEditingController();
  String gender = "Select Type";
  DateTime? documentDate;
  List<File> images = [];

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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: fileTitle,
                        style: detailsTextStyle,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter file title';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: fileDescription,
                        style: detailsTextStyle,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black)),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter file description';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: DropdownButton<String>(
                        value: gender,
                        isExpanded: true,
                        items: <String>['Select Type', 'Prescription', 'Report']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: detailsTextStyle,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            gender = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        pickDate(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                                child: DetailsText(
                              text: (documentDate == null)
                                  ? "Select date"
                                  : "${documentDate.toString().split(" ")[0]}",
                            )),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Icon(
                                size: 30,
                                Icons.calendar_month,
                                color: textColorDark,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () async {
                        String message = await pickImage();
                        Fluttertoast.showToast(
                            msg: message,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        setState(() {});
                      },
                      child: DetailsText(
                        text: 'Choose Image',
                        textColor: textColorDark,
                      ),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () async {
                        String message = await resizeImage(images);
                        Fluttertoast.showToast(
                            msg: message,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: DetailsText(
                        text: 'Upload',
                        textColor: textColorDark,
                      ),
                    ),
                  ),
                ],
              ),
              images.isNotEmpty
                  ? Container(
                      height: 500,
                      padding: EdgeInsets.all(8),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5, // Number of columns
                          crossAxisSpacing: 4.0, // Spacing between columns
                          mainAxisSpacing: 4.0, // Spacing between rows
                        ),
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                            images[index],
                            fit: BoxFit
                                .cover, // Ensures the image covers the card
                          );
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Future<String> resizeImage(List<File> imageFiles) async {
    List<File> resizedImages = [];

    for (int i = 0; i < imageFiles.length; i++) {
      final img.Image originalImage =
          img.decodeImage(await imageFiles[i].readAsBytes())!;

      final img.Image resizedImage = img.copyResize(
        originalImage,
        width: (originalImage.width / 2).round(),
        height: (originalImage.height / 2).round(),
      );

      final Directory tempDir = await getTemporaryDirectory();
      final String imgPath = path.join(
          tempDir.path, "Resized $i ${DateTime.now().millisecondsSinceEpoch}");
      final File rImageFile = File(imgPath)
        ..writeAsBytesSync(img.encodeJpg(resizedImage));
      resizedImages.add(rImageFile);
    }

    if (resizedImages.length > 0) {
      String message = await createPdf(resizedImages);
      return message;
    } else {
      return "Failed to resize images";
    }
  }

  Future<String> createPdf(List<File> imageFiles) async {
    final pw.Document pdf = pw.Document();
    for (int i = 0; i < imageFiles.length; i++) {
      final image = pw.MemoryImage(imageFiles[i].readAsBytesSync());
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            );
          },
        ),
      );
    }

    final Directory tempDir = await getTemporaryDirectory();
    final String pdfPath = path.join(tempDir.path, 'uploadImages.pdf');
    final File pdfFile = File(pdfPath);
    DocumentServices docServices = DocumentServices();
    await pdfFile.writeAsBytes(await pdf.save());
    String apiResponse = await docServices.uploadDocument(
        pdfFile,
        currentUserInfo.userId,
        "First Upload",
        "First Upload Description",
        pdfFile.runtimeType.toString(),
        1);

    return 'PDF saved at: $pdfPath';
  }

  Future<String> pickImage() async {
    List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      for (int i = 0; i < pickedFiles.length; i++) {
        File file = File(pickedFiles[i].path);
        images.add(file);
      }
      return "${images.length} image picked";
    } else {
      return 'No image picked';
    }
  }

  Future<void> pickDate(BuildContext context) async {
    if (documentDate == null) {
      documentDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: documentDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != documentDate)
      setState(() {
        documentDate = picked;
      });
  }
}
