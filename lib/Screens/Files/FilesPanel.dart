import 'package:flutter/material.dart';
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Components/HeadingText.dart';
import 'package:phr_app/Screens/Files/FilePreview.dart';
import 'package:phr_app/Screens/Files/FileUpload.dart';
import 'package:phr_app/Services/DocumentsServices.dart';

import '../../Models/Document.dart';

class FilesPanel extends StatefulWidget {
  const FilesPanel({super.key});

  @override
  State<FilesPanel> createState() => _FilesPanelState();
}

class _FilesPanelState extends State<FilesPanel> {
  DocumentServices documentServices = DocumentServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeadingText(text: 'Files', textColor: textColorLite,),
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
          FutureBuilder<List<Document>>(
            future: documentServices.documentListOfUser(currentUserInfo.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              }

              List<Document> documents = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return Card(
                      surfaceTintColor: Colors.white,
                      elevation: 1,
                      child: ListTile(onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => FilePreview(documentId:  documents[index].documentId!)),
                        );
                      },
                        title: DetailsText(text: documents[index].documentTitle!),
                        // trailing: DetailsText(text: documents[index].docType!),
                        subtitle: DetailsText(text: "${(documents[index].documentDescription!.length>40)?documents[index].documentDescription!.substring(0,39)+'...':documents[index].documentDescription!}\n${documents[index].docType!}"),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
          color: textColorLite,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const FileUpload()),
          );
        },
        backgroundColor: themeColorDark,
      ),
    );
  }
}
