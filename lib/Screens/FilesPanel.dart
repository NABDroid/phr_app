import 'package:flutter/material.dart';
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Components/HeadingText.dart';
import 'package:phr_app/Services/DocumentsServices.dart';

import '../Models/Document.dart';

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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          FutureBuilder<List<Document>>(
            future: documentServices.documentsByUserId(currentUserInfo.userId),
            // Replace with your actual future method
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              }

              List<Document> documents = snapshot.data!;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white10,
                        elevation: 1,
                        child: ListTile(
                          title: HeadingText(text: documents[index].documentTitle!, textColor: textColorDark, alignment: TextAlign.start),
                          trailing: DetailsText(text: documents[index].docType!, textColor: textColorDark, alignment: TextAlign.start),
                          subtitle: DetailsText(text: documents[index].documentDescription!, textColor: textColorDark, alignment: TextAlign.start),
                        ),
                      );
                    },
                  ),
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
        onPressed: () {},
        backgroundColor: themeColorDark,
      ),
    );
  }
}
