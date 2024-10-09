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
  String fileType = "Select Type";
  DateTime? documentDate;
  List<File> images = [];
  ValueNotifier<String> buttonText = ValueNotifier<String>("Upload");

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
                      child: DropdownButton<String>(
                        value: fileType,
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
                            fileType = newValue!;
                          });
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
                      child: TextFormField(
                        controller: fileDescription,
                        minLines: 1,
                        maxLines: 5,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 40) / 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                      ),
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
                        textColor: textColorLite,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 40) / 2,
                    child: ValueListenableBuilder<String>(
                      valueListenable: buttonText,
                      builder: (context, value, child) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                          onPressed: (value == "Upload")
                              ? () async {
                                  String message = await uploadImage();
                                  setState(() {});
                                  buttonText.value = "Upload";
                                  Fluttertoast.showToast(
                                      msg: message,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              : null,
                          child: DetailsText(
                            text: value,
                            textColor: textColorLite,
                          ),
                        );
                      },
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
                          crossAxisCount: 5,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
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

  Future<String> uploadImage() async {
    if (fileType == "Select Type") {
      return "Select file type";
    } else if (fileTitle.text.trim() == "") {
      return "Enter file type";
    } else if (fileDescription.text.trim() == "") {
      return "Enter file description";
    }

    if (images.length > 0) {
      String message = await resizeImage(images);
      images.clear();
      return message;
    } else {
      return "No image selected";
    }
  }

  Future<String> resizeImage(List<File> imageFiles) async {
    buttonText.value = "Compressing...";
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
      buttonText.value = "Upload";
      return "Failed to resize images";
    }
  }

  Future<String> createPdf(List<File> imageFiles) async {
    buttonText.value = "Making PDF..";
    try {
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
      int docType = 1;
      (fileType == "Prescription") ? docType = 1 : docType = 2;
      buttonText.value = "Uploading file..";

      String apiResponse = await docServices.uploadDocument(
          pdfFile,
          currentUserInfo.userId,
          fileTitle.text.trim(),
          fileDescription.text.trim(),
          pdfFile.runtimeType.toString(),
          docType);

      return apiResponse;
    } catch (e) {
      buttonText.value = "Upload";
      return e.toString();
    }
  }

  Future<String> pickImage() async {
    List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      images.clear();
      for (int i = 0; i < pickedFiles.length; i++) {
        File file = File(pickedFiles[i].path);
        images.add(file);
      }
      return "${images.length} image picked";
    } else {
      return 'No image picked';
    }
  }
}
