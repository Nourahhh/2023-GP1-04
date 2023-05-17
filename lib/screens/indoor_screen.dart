import 'package:naqi_app/http_handler.dart';
import 'dart:convert';
import 'package:naqi_app/sensor.dart';
import 'package:flutter/material.dart';

class IndoorPage extends StatefulWidget {
  IndoorPage({Key? key}) : super(key: key);

  @override
  _IndoorPageState createState() => _IndoorPageState();
}

class _IndoorPageState extends State<IndoorPage>
    with AutomaticKeepAliveClientMixin {
  HTTPHandler httpHandler = HTTPHandler();
  Sensor sensorReadings = Sensor();

  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 245, 248),
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
                          stream: httpHandler.getReadings(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              print("no data");
                              return const CircularProgressIndicator();
                            } else {
                              var data = jsonDecode(snapshot.data.toString());
                              List<int> readings =
                                  sensorReadings.readData(data);
                              return sensorReadings.showData(readings);
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

  @override
  bool get wantKeepAlive => true;
}
