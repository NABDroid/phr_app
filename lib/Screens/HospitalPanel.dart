import 'package:flutter/material.dart';
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Components/HeadingText.dart';
import 'package:phr_app/Screens/AmbulanceListScreen.dart';
import 'package:phr_app/Services/DocumentsServices.dart';
import 'package:phr_app/Services/HospitalServices.dart';

import '../Models/Hospital.dart';
import 'HospitalDetailsScreen.dart';

class HospitalPanel extends StatefulWidget {
  const HospitalPanel({super.key});

  @override
  State<HospitalPanel> createState() => _HospitalPanelState();
}

class _HospitalPanelState extends State<HospitalPanel> {
  HospitalServices hospitalServices = HospitalServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeadingText(text: 'Hospital List', textColor: textColorLite,),
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
          FutureBuilder<List<Hospital>>(
            future: hospitalServices.fetchHospitals(0,0,0),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final hospital = snapshot.data![index];
                    return Card(
                      color: Colors.white10,
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HospitalDetailsScreen(hospitalId: hospital.hospitalId)),
                          );
                        },
                        title: DetailsText(text:  hospital.hospitalName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailsText(text: hospital.hospitalAddress),
                            DetailsText(text: hospital.contactNo),
                          ],
                        ),
                        trailing: DetailsText(text: 'Seats: ${hospital.bookedSeat}/${hospital.noOfSeat-hospital.bookedSeat}'),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ],
      ),
    );
  }
}
