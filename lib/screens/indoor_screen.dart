import 'package:naqi_app/sensor.dart';
import 'dart:convert';
import 'package:naqi_app/indoorAirQuality.dart';
import 'package:flutter/material.dart';
import 'package:naqi_app/fan.dart';
import 'package:naqi_app/controller.dart';

class IndoorPage extends StatefulWidget {
  IndoorPage({Key? key}) : super(key: key);

  @override
  _IndoorPageState createState() => _IndoorPageState();
}

class _IndoorPageState extends State<IndoorPage>
    with AutomaticKeepAliveClientMixin {
  //StreamSubscription<String>? _streamSubscription;
  Controller controller = Controller();
  @override
  void initState() {
    super.initState();
    //Listen to the stream
    sensor.getReadings().listen((data) {
      // This callback function is called every time new data is received from the stream
      var jsonData = jsonDecode(data);
      List<int> reading = sensorReadings.readData(jsonData);
      var co2 = reading[2];
      controller.checkAirQualityData(co2);
    });
  }

  @override
  bool get wantKeepAlive => true;
  Sensor sensor = Sensor();
  Fan fan = Fan();
  IndoorAirQuality sensorReadings = IndoorAirQuality();
  static bool isSwitchOn = false;

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
                            List<int> readings = sensorReadings.readData(data);
                            List<String> levels =
                                sensorReadings.calculateLevel(readings);
                            return Column(children: [
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sensorReadings.viewIndoorAirQuality(
                                      readings, context),
                                ],
                              ),
                              Row(children: [controlFan()]),
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

  Widget controlFan() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Text(
            'تشغيل/إيقاف المروحة ',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: // Define a boolean variable to keep track of switch state

// Define the switch
              Switch(
            activeColor: const Color.fromARGB(255, 255, 255, 255),
            activeTrackColor: const Color(0xff45A1B6),
            inactiveThumbColor: Colors.blueGrey.shade600,
            inactiveTrackColor: Colors.grey.shade400,
            splashRadius: 50.0,
            value: isSwitchOn, // Use the boolean variable to set switch state
            onChanged: (value) => setState(() {
              if (value) {
                fan.turnOn();
                fan.updateSwitch(1);
              } else {
                fan.turnOff();
                fan.updateSwitch(0);
              }
              isSwitchOn = value; // Update the boolean variable
            }),
          ),
        ),
      ],
    );
  }
}
