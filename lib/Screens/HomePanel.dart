import 'package:flutter/material.dart';
import '../Components/Global.dart';
import '../Components/HeadingText.dart';

class HomePanel extends StatefulWidget {
  const HomePanel({super.key});

  @override
  State<HomePanel> createState() => _HomePanelState();
}

class _HomePanelState extends State<HomePanel> {
  TextEditingController searchHospitalNameCont = TextEditingController();


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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: Row(
                  children: [
                    const Image(
                      height: 100,
                      image: AssetImage('asset/userPhoto.png'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailsText(
                              text: "Welcome",
                              textColor: textColorDark,
                              alignment: TextAlign.start),
                          HeadingText(
                              text: currentUserInfo.fullName!,
                              textColor: textColorDark,
                              alignment: TextAlign.start),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.notifications_none,
                      size: 40,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: TextField(
                  controller: searchHospitalNameCont,
                  style: detailsTextStyle,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:
                        BorderSide(width: 2, color: Colors.black)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide:
                        BorderSide(width: 1, color: Colors.black)),
                  ),
                ),
              ),
              Card(
                color: Colors.white10,
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: DetailsText(text: "Search for hospital",textColor: textColorDark,alignment: TextAlign.center,)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
