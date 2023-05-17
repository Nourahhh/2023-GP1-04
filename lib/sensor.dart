//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Sensor {
  int co2 = 0;
  var temp = 0;
  var hum = 0;
  var tvoc = 0;

  dynamic readData(dynamic data) {
    if (data.containsKey('uplink_message')) {
      var paylaod = (data as Map)['uplink_message'];

      if (paylaod.containsKey('decoded_payload')) {
        var paylaod1 = (paylaod as Map)['decoded_payload'];

        if (paylaod1.containsKey('co2')) {
          print('yes');
          co2 = ((data as Map)['uplink_message']['decoded_payload']['co2'])
              .round();
          temp = (data as Map)['uplink_message']['decoded_payload']
                  ['temperature']
              .round();
          hum = (data as Map)['uplink_message']['decoded_payload']['humidity']
              .round();
          tvoc = (data as Map)['uplink_message']['decoded_payload']['tvoc']
              .round();
        } else {
          if (co2 == 0) {
            return Center(
              child: Container(
                  width: 16, height: 16, child: CircularProgressIndicator()),
            );
          }
        }
      } else {
        if (co2 == 0)
          return Center(
            child: Container(
                width: 16, height: 16, child: CircularProgressIndicator()),
          );
      }
    } else {
      if (co2 == 0) {
        return Center(
          child: Container(
              width: 16, height: 16, child: CircularProgressIndicator()),
        );
      }
    }
    List<int> readings = [
      temp,
      hum,
      co2,
      tvoc,
    ];
    return readings;
  }

  Widget showData(List<int> readings) {
    List<String> levels = calculateLevel(readings);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _cardMenu(
              title: 'درجة الحرارة',
              reading: readings[0].toString() + '\u00B0',
              level: levels[0],
              percent: calculatePercent(readings)[0],
            ),
            _cardMenu(
              title: 'مستوى الرطوبة',
              reading: readings[1].toString() + '%',
              level: levels[1],
              percent: calculatePercent(readings)[1],
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _cardMenu(
              title: 'CO2',
              reading: readings[2].toString(),
              level: levels[2],
              percent: calculatePercent(readings)[2],
            ),
            _cardMenu(
              title: 'TVOC',
              reading: readings[3].round().toString(),
              level: levels[3],
              percent: calculatePercent(readings)[3],
            ),
          ],
        ),
      ],
    );
  }

  List<double> calculatePercent(List<int> readings) {
    List<double> percentages = [];
    // temp percentage
    percentages.add(readings[0] / 40);

    // humidity percentage
    percentages.add(readings[1] / 100);

    //co2 percantsge
    percentages.add(readings[2] / 2000);

    //tvoc percentage
    percentages.add(readings[3] / 300);

    return percentages;
  }

  List<String> calculateLevel(List<int> readings) {
    List<String> levels = [];
    //temprature level
    if (readings[0] < 10) {
      levels.add("بارد");
    } else if ((readings[0] >= 10) & (readings[0] < 28)) {
      levels.add("معتدل");
    } else if (readings[0] >= 28) {
      levels.add("حار");
    }
    //humidity level
    if (readings[1] < 30) {
      levels.add("منخفض");
    } else if ((readings[1] >= 30) & (readings[1] <= 60)) {
      levels.add("متوسط");
    } else if (readings[1] > 60) {
      levels.add("عالي");
    }
    //co2 level
    if (readings[2] <= 1000) {
      levels.add("ممتاز");
    } else if ((readings[2] > 1000) & (readings[2] < 1500)) {
      levels.add("ملوث");
    } else if (readings[2] >= 1500) {
      levels.add("ملوث جدا");
    }
    //tvoc level
    if (readings[3] <= 100) {
      levels.add("ممتاز");
    } else if ((readings[3] > 100) & (readings[3] < 200)) {
      levels.add("ملوث");
    } else if (readings[3] >= 200) {
      levels.add("ملوث جدا");
    }
    return levels;
  }

  Widget _cardMenu({
    required String title,
    required String reading,
    required String level,
    required double percent,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 25,
      ),
      width: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          CircularPercentIndicator(
            animation: true,
            animationDuration: 1000,
            circularStrokeCap: CircularStrokeCap.round,
            radius: 90,
            lineWidth: 5,
            percent: percent,
            //backgroundColor: Colors.blueGrey,
            progressColor: const Color(0xff45A1B6),
            center: Text(
              reading.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
          ),
          const SizedBox(height: 12),
          Text(
            level,
            style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
          ),
        ],
      ),
      //),
    );
  }
}
