import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phr_app/Components/Global.dart';
import 'package:phr_app/Components/HeadingText.dart';
import 'package:phr_app/Services/HospitalServices.dart';
import 'package:http/http.dart' as http;
import '../../Models/Hospital.dart';
import 'HospitalDetailsScreen.dart';

class HospitalPanel extends StatefulWidget {
  const HospitalPanel({super.key});

  @override
  State<HospitalPanel> createState() => _HospitalPanelState();
}

class _HospitalPanelState extends State<HospitalPanel> {
  HospitalServices hospitalServices = HospitalServices();

  List<dynamic> areas = [];
  List<dynamic> parentAreas = [];
  List<dynamic> childAreas = [];
  int? selectedParentId;
  int? selectedChildId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAreas();
  }

  Future<void> fetchAreas() async {
    final response = await http.get(Uri.parse('$apiURL/api/Global/areaMap'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        areas = data['data'];
        parentAreas = areas.where((area) => area['areaTypeId'] == 1).toList();
      });
    } else {
      throw Exception('Failed to load areas');
    }
  }

  void updateChildAreas(int parentId) {
    setState(() {
      childAreas = areas.where((area) => area['parentId'] == parentId && area['areaTypeId'] == 2).toList();
      selectedChildId = null;
    });
  }

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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Card(
                        child: Row(


                          children: [
                            DetailsText(text: "Division: "),
                            Flexible(
                              child: DropdownButton<int>(
                                value: selectedParentId,
                                items: parentAreas.map((area) {
                                  return DropdownMenuItem<int>(
                                    value: area['areaId'],
                                    child: DetailsText(text: area['areaName']),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedParentId = value;
                                    updateChildAreas(value!);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Card(
                        child: Row(
                          children: [
                            DetailsText(text: "District"),
                            DropdownButton<int>(
                              value: selectedChildId,
                              items: childAreas.map((area) {
                                return DropdownMenuItem<int>(
                                  value: area['areaId'],
                                  child: DetailsText(text: area['areaName']),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedChildId = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                // height: 500,
                child: FutureBuilder<List<Hospital>>(
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
                            surfaceTintColor: Colors.white,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
