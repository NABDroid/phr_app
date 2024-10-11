import 'package:flutter/material.dart';
import 'package:phr_app/Services/HospitalServices.dart';

import '../Components/Global.dart';
import '../Models/DoctorInfo.dart';

class DoctorListPage extends StatefulWidget {
  final int hospitalId;

  const DoctorListPage({Key? key, required this.hospitalId}) : super(key: key);

  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  HospitalServices hospitalServices  = HospitalServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        FutureBuilder<List<DoctorInfo>>(
          future: hospitalServices.fetchDoctors(1),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No doctors available'));
            } else {
              final doctors = snapshot.data!;
              return ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return ListTile(
                    title: Text(doctor.doctorName),
                    subtitle: Text('${doctor.achievedDegrees}\n${doctor.chamberAddress}'),
                    isThreeLine: true,
                    trailing: Text(doctor.workTimes),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
