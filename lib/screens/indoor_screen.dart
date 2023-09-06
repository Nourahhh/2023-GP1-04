import 'package:naqi_app/sensor.dart';
import 'dart:convert';
import 'package:naqi_app/indoorAirQuality.dart';
import 'package:flutter/material.dart';
import 'package:naqi_app/fan.dart';
import 'package:naqi_app/controller.dart';
import 'package:naqi_app/firebase.dart';

class IndoorPage extends StatefulWidget {
  IndoorPage({Key? key}) : super(key: key);

  @override
  _IndoorPageState createState() => _IndoorPageState();
}

class _IndoorPageState extends State<IndoorPage>
    with AutomaticKeepAliveClientMixin {
  Controller controller = Controller();

  @override
  void initState() {
    super.initState();
    //Listen to the stream
    sensor.getReadings().listen((data) {
      // This callback function is called every time new data is received from the stream
      var jsonData = jsonDecode(data);
      List<dynamic> reading = sensorReadings.readData(jsonData);
      var co2 = reading[2];
      controller.checkAirQualityData(co2);
    });
    Future<String> fanStatus = firebase.getStatus();
    fanStatus.then((value) {
      status = value;
    });
  }

  @override
  bool get wantKeepAlive => true;
  Sensor sensor = Sensor();
  Fan fan = Fan();
  IndoorAirQuality sensorReadings = IndoorAirQuality();
  static bool isSwitchOn = false;
  String status = '';
  FirebaseService firebase = FirebaseService();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 0, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [],
              ),
              Expanded(
                child: Container(
                  height: 100.0,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 26),
                      StreamBuilder<String>(
                        stream: sensor.getReadings(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            print("no data");
                            return CircularProgressIndicator();
                          } else {
                            var data = jsonDecode(snapshot.data.toString());
                            List<dynamic> readings =
                                sensorReadings.readData(data);
                            List<String> levels =
                                sensorReadings.calculateLevel(readings);

                            return Column(children: [
                              Row(
                                children: [
                                  sensorReadings.checkTime(readings[3]),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sensorReadings.viewIndoorAirQuality(
                                      readings, context),
                                ],
                              ),
                              Row(children: [controlFanWidget()]),
                            ]);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget controlFanWidget() {
    Future<String> fanStatus = firebase.getStatus();
    fanStatus.then((value) {
      status = value;
    });

    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 2),
      child: Container(
        width: 310, // Adjust the width as needed
        height: 100, // Adjust the height as needed
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 251, 251, 251),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 8,
              offset: Offset(0, 5),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 240, 242, 243),
                ),
                child: CircleAvatar(
                  child: Image.asset(
                    'images/fan.png',
                    height: 30,
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                          'المروحة',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (status == '0')
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 70),
                              child: Text(
                                'قيد الإيقاف',
                              ),
                            ),
                          ),
                        if (status == '1')
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 70),
                              child: Text(
                                'قيد التشغيل',
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Switch(
                activeColor: const Color.fromARGB(255, 255, 255, 255),
                activeTrackColor: const Color(0xff45A1B6),
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                value: isSwitchOn,
                onChanged: (value) => setState(() {
                  if (value) {
                    fan.turnOn();
                    fan.updateSwitch(1);
                  } else {
                    fan.turnOff();
                    fan.updateSwitch(0);
                  }
                  isSwitchOn = value;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
