import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqi_app/firebase.dart';
import 'package:naqi_app/indoorAirQuality.dart';

class healthStatusPage extends StatefulWidget {
  healthStatusPage({Key? key}) : super(key: key);

  @override
  _healthStatusPageState createState() => _healthStatusPageState();
}

class _healthStatusPageState extends State<healthStatusPage> {
  IndoorAirQuality indoorAirQuality = IndoorAirQuality();

  // Initial Selected Value
  String dropdownvalue = FirebaseService.healthStatusLevel;

  // List of items in our dropdown menu
  var items = [
    'خفيف',
    'متوسط',
    'شديد',
  ];

  @override
  void initState() {
    super.initState();
  }

  void updateInfo(var feild, var feildValue) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({feild: feildValue});
      setState(() {
        feild = feildValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الحالة الصحية',
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('هل تعاني من ظروف صحية تنفسية؟',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Switch(
                                activeColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                activeTrackColor: const Color(0xff45A1B6),
                                inactiveThumbColor: Colors.blueGrey.shade600,
                                inactiveTrackColor: Colors.grey.shade400,
                                splashRadius: 50.0,
                                value: FirebaseService.healthStatus,
                                onChanged: (value) => setState(() {
                                  FirebaseService.healthStatus =
                                      !FirebaseService.healthStatus;
                                  updateInfo('healthStatus',
                                      FirebaseService.healthStatus);
                                  if (!FirebaseService.healthStatus)
                                    updateInfo('healthStatusLevel', 'خفيف');
                                  dropdownvalue = 'خفيف';
                                  // FirebaseService.healthStatus = value;
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: 1),
                        ],
                      ),
                    ),
                    if (FirebaseService.healthStatus == true)
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('مستوى الحالة الصحية',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                indoorAirQuality.infoWidget(context, ''),
                              ],
                            ),
                            SizedBox(height: 1),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.health_and_safety),
                                title: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border:
                                        InputBorder.none, // Remove the border
                                    contentPadding:
                                        EdgeInsets.zero, // Remove padding
                                  ),

                                  // Initial Value
                                  value: dropdownvalue,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                      FirebaseService.healthStatusLevel =
                                          dropdownvalue;
                                      updateInfo('healthStatusLevel',
                                          FirebaseService.healthStatusLevel);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
