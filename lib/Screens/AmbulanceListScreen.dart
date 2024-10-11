import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phr_app/Services/HospitalServices.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Components/Global.dart';
import '../Components/HeadingText.dart';
import '../Models/Ambulance.dart';

class AmbulanceList extends StatefulWidget {
  final int hospitalId;

  const AmbulanceList({required this.hospitalId});

  @override
  State<AmbulanceList> createState() => _AmbulanceListState();
}

class _AmbulanceListState extends State<AmbulanceList> {
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    HospitalServices hospitalServices = HospitalServices();

    return Stack(
      children: [
        Positioned.fill(
          child: Image(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        FutureBuilder<List<Ambulance>>(
          future: hospitalServices.fetchAmbulances(widget.hospitalId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No ambulances available'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final ambulance = snapshot.data![index];
                return Card(
                  color: Colors.white10,
                  child: ListTile(
                    title: DetailsText(text: ambulance.ambulanceTitle),
                    subtitle: DetailsText(
                        text:
                        '${ambulance.ambulanceDetails} \nDriver: ${ambulance.driverContact}'),
                    trailing: GestureDetector(
                        onTap: () {
                          makeCallToDriver(ambulance.driverContact);
                        },
                        child: Icon(
                          Icons.call,
                          color: Colors.black,
                          size: 30,
                        )),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void makeCallToDriver(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
