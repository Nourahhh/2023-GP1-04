import 'package:naqi_app/sensor.dart';
import 'dart:convert';
import 'package:naqi_app/indoorAirQuality.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class IndoorPage extends StatefulWidget {
  IndoorPage({Key? key}) : super(key: key);

  @override
  _IndoorPageState createState() => _IndoorPageState();
}

class _IndoorPageState extends State<IndoorPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Sensor sensor = Sensor();
  IndoorAirQuality sensorReadings = IndoorAirQuality();

  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
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
                      const SizedBox(height: 16),
                      const SizedBox(height: 48),
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
                              // return sensorReadings.showData(readings);
                              List<String> levels =
                                  sensorReadings.calculateLevel(readings);
                              return sensorReadings.showData(readings, context);
                            }
                          }),
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
