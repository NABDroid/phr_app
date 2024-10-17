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

  ValueNotifier<bool> activeSubmitButton = ValueNotifier<bool>(true);
  List<Hospital> hospitals = [];


  List<dynamic> areas = [];
  List<dynamic> divisions = [];
  List<dynamic> districts = [];
  int? selectedDivisionId;
  int? selectedDistrictId;

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


        divisions = areas.where((area) => area['areaTypeId'] == 1).toList();
      });
    } else {
      throw Exception('Failed to load areas');
    }
  }

  void updateChildAreas(int parentId) {
    setState(() {
      districts = areas.where((area) => area['parentId'] == parentId && area['areaTypeId'] == 2).toList();
      selectedDistrictId = null;
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
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DetailsText(text: "Division: ", fSize: 12),
                                Flexible(
                                  child: DropdownButton<int>(
                                    value: selectedDivisionId,
                                    hint: DetailsText(text: "Select division", fSize: 12),
                                    items: divisions.map((area) {
                                      return DropdownMenuItem<int>(
                                        value: area['areaId'],
                                        child: DetailsText(text: area['areaName'], fSize: 12),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedDivisionId = value;
                                        updateChildAreas(value!);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DetailsText(text: "District: ", fSize: 12),
                                DropdownButton<int>(
                                  value: selectedDistrictId,
                                  hint: DetailsText(text: "Select district", fSize: 12),
                                  items: districts.map((area) {
                                    return DropdownMenuItem<int>(
                                      value: area['areaId'],
                                      child: DetailsText(text: area['areaName'], fSize: 12),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDistrictId = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: activeSubmitButton,
                        builder: (context, value, child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: themeColorDark),
                            onPressed: (value)
                                ? () async {
                              activeSubmitButton.value = false;
                              await getHospitals();
                              activeSubmitButton.value = true;
                            }
                                : null,
                            child: (value)
                                ? DetailsText(
                                text: "Show",
                                textColor: textColorLite,
                                alignment: TextAlign.start)
                                : DetailsText(
                                text: "Loading...",
                                textColor: textColorDark,
                                alignment: TextAlign.start),
                          );
                        },
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              ),


              ValueListenableBuilder<bool>(
                valueListenable: activeSubmitButton,
                builder: (context, value, child) {
                  if(value){
                    return Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: (hospitals.length>0)?ListView.builder(
                            itemCount: hospitals.length,
                            itemBuilder: (context, index) {
                              final hospital = hospitals[index];
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
                          ): DetailsText(text: "No hospital found")


                        // FutureBuilder<List<Hospital>>(
                        //   future: hospitalServices.fetchHospitals(0,0,0),
                        //   builder: (context, snapshot) {
                        //
                        //
                        //
                        //     if (snapshot.connectionState == ConnectionState.waiting) {
                        //       return Center(child: CircularProgressIndicator());
                        //     } else if (snapshot.hasError) {
                        //       return Center(child: Text('Error: ${snapshot.error}'));
                        //     } else if (snapshot.hasData) {
                        //       return ListView.builder(
                        //         itemCount: snapshot.data!.length,
                        //         itemBuilder: (context, index) {
                        //           final hospital = snapshot.data![index];
                        //           return Card(
                        //             surfaceTintColor: Colors.white,
                        //             child: ListTile(
                        //               onTap: (){
                        //                 Navigator.of(context).push(
                        //                   MaterialPageRoute(
                        //                       builder: (context) => HospitalDetailsScreen(hospitalId: hospital.hospitalId)),
                        //                 );
                        //               },
                        //               title: DetailsText(text:  hospital.hospitalName),
                        //               subtitle: Column(
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   DetailsText(text: hospital.hospitalAddress),
                        //                   DetailsText(text: hospital.contactNo),
                        //                 ],
                        //               ),
                        //               trailing: DetailsText(text: 'Seats: ${hospital.bookedSeat}/${hospital.noOfSeat-hospital.bookedSeat}'),
                        //             ),
                        //           );
                        //         },
                        //       );
                        //     } else {
                        //       return Center(child: Text('No data available'));
                        //     }
                        //   },
                        // ),
                      ),
                    );
                  } else{
                    return Expanded(child: Center(child: DetailsText(text: "Searching hospitals...",)));
                  }



                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  getHospitals() async {
    HospitalServices hospitalServices = HospitalServices();
    // print(selectedDivisionId);
    // print(selectedDistrictId);

    int divisionId = (selectedDivisionId != null)?selectedDivisionId!:0;
    int districtId = (selectedDistrictId != null)?selectedDistrictId!:0;

    hospitals = await hospitalServices.fetchHospitals(divisionId,districtId,0);


    // setState(() {
    //
    // });








  }
}
