import 'package:flutter/material.dart';
import 'package:phr_app/Services/DocumentsServices.dart';

import '../Models/Hospital.dart';

class HospitalPanel extends StatefulWidget {
  const HospitalPanel({super.key});

  @override
  State<HospitalPanel> createState() => _HospitalPanelState();
}

class _HospitalPanelState extends State<HospitalPanel> {
  DocumentServices documentServices = DocumentServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital List'),
      ),
      body: FutureBuilder<List<Hospital>>(
        future: documentServices.fetchHospitals(),
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
                  child: ListTile(
                    title: Text(hospital.hospitalName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address: ${hospital.hospitalAddress}'),
                        Text('Seats: ${hospital.noOfSeat}, Booked: ${hospital.bookedSeat}'),
                        Text('Contact: ${hospital.contactNo}'),
                      ],
                    ),
                    trailing: Icon(
                      hospital.isActive ? Icons.check_circle : Icons.cancel,
                      color: hospital.isActive ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
