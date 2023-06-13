import 'package:naqi_app/sensor.dart';
import 'dart:convert';
import 'package:naqi_app/indoorAirQuality.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:naqi_app/fan.dart';
import 'package:firebase_database/firebase_database.dart';

class IndoorPage extends StatefulWidget {
  IndoorPage({Key? key}) : super(key: key);

  @override
  _IndoorPageState createState() => _IndoorPageState();
}

class _IndoorPageState extends State<IndoorPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
  Sensor sensor = Sensor();
  IndoorAirQuality sensorReadings = IndoorAirQuality();
  static bool isSwitchOn = false;

  Fan fan = Fan();

  Widget build(BuildContext context) {
    super.build(context);

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
                              return const CircularProgressIndicator();
                            } else {
                              var data = jsonDecode(snapshot.data.toString());
                              List<int> readings =
                                  sensorReadings.readData(data);

                              List<String> levels =
                                  sensorReadings.calculateLevel(readings);
                              return sensorReadings.viewIndoorAirQuality(
                                  readings, context);
                            }
                          }),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10),
                            child: Text(
                              'تشغيل/إيقاف المروحة ',
                              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: // Define a boolean variable to keep track of switch state

// Define the switch
                                Switch(
                              activeColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              activeTrackColor: const Color(0xff45A1B6),
                              inactiveThumbColor: Colors.blueGrey.shade600,
                              inactiveTrackColor: Colors.grey.shade400,
                              splashRadius: 50.0,
                              value:
                                  isSwitchOn, // Use the boolean variable to set switch state
                              onChanged: (value) => setState(() {
                                if (value) {
                                  fan.turnOn();
                                  fan.updateSwitch(1);
                                } else {
                                  fan.turnOff();
                                  fan.updateSwitch(0);
                                }
                                isSwitchOn =
                                    value; // Update the boolean variable
                              }),
                            ),
                          ),
                        ],
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
}
