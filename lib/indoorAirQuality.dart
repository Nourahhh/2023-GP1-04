//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class IndoorAirQuality {
  var co2 = 0;
  var temp = 0;
  var hum = 0;
  var tvoc = 0;

  dynamic readData(dynamic data) {
    if (data.containsKey('uplink_message')) {
      var paylaod = (data as Map)['uplink_message'];
      if (paylaod.containsKey('decoded_payload')) {
        var paylaod1 = (paylaod as Map)['decoded_payload'];
        if (paylaod1.containsKey('co2')) {
          co2 = ((data as Map)['uplink_message']['decoded_payload']['co2'])
              .round();
          temp = (data as Map)['uplink_message']['decoded_payload']
                  ['temperature']
              .round();
          hum = (data as Map)['uplink_message']['decoded_payload']['humidity']
              .round();
          tvoc = (data as Map)['uplink_message']['decoded_payload']['tvoc']
              .round();
        }
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

  Widget viewIndoorAirQuality(List<int> readings, context) {
    List<String> levels = calculateLevel(readings);
    Map<String, Color> airQuality_color = calculateAirQuality(levels);
    String airQuality = airQuality_color.keys.first;
    Color color = airQuality_color.values.first;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "مستوى جودة الهواء: ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
              padding: EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 20),
              child: Text(
                airQuality,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardMenu(
                  context: context,
                  title: 'درجة الحرارة',
                  reading: readings[0].toString() + '\u00B0',
                  level: levels[0],
                  percent: calculatePercentege(readings)[0],
                ),
                _cardMenu(
                  context: context,
                  title: 'مستوى الرطوبة',
                  reading: readings[1].toString() + '%',
                  level: levels[1],
                  percent: calculatePercentege(readings)[1],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardMenu(
                  context: context,
                  title: 'ثاني أكسيد الكربون',
                  reading: readings[2].toString(),
                  level: levels[2],
                  percent: calculatePercentege(readings)[2],
                ),
                _cardMenu(
                  context: context,
                  title: 'المركبات العضوية المتطايرة',
                  reading: readings[3].round().toString(),
                  level: levels[3],
                  percent: calculatePercentege(readings)[3],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<double> calculatePercentege(List<int> readings) {
    List<double> percentages = [];
    // temp percentage
    percentages.add(readings[0] / 40);

    // humidity percentage
    percentages.add(readings[1] / 100);

    // co2 percantsge
    percentages.add(readings[2] / 2000);

    // tvoc percentage
    percentages.add(readings[3] / 300);

    return percentages;
  }

  List<String> calculateLevel(List<int> readings) {
    List<String> levels = [];
    // temprature level
    if (readings[0] < 10) {
      levels.add("بارد");
    } else if ((readings[0] >= 10) & (readings[0] < 28)) {
      levels.add("معتدل");
    } else if (readings[0] >= 28) {
      levels.add("حار");
    }
    // humidity level
    if (readings[1] < 30) {
      levels.add("منخفض");
    } else if ((readings[1] >= 30) & (readings[1] <= 60)) {
      levels.add("متوسط");
    } else if (readings[1] > 60) {
      levels.add("عالي");
    }
    // co2 level
    if (readings[2] <= 1000) {
      levels.add("ممتاز");
    } else if ((readings[2] > 1000) & (readings[2] < 1500)) {
      levels.add("ملوث");
    } else if (readings[2] >= 1500) {
      levels.add("ملوث جدا");
    }
    // tvoc level
    if (readings[3] <= 100) {
      levels.add("ممتاز");
    } else if ((readings[3] > 100) & (readings[3] < 200)) {
      levels.add("ملوث");
    } else if (readings[3] >= 200) {
      levels.add("ملوث جدا");
    }
    return levels;
  }

  Map<String, Color> calculateAirQuality(List<String> levels) {
    String airQuality = 'ممتاز';
    for (String level in levels) {
      if (level == "ملوث جدا") {
        airQuality = level;
        return {airQuality: Colors.red};
      }
      if (level == "ملوث") {
        airQuality = level;
        return {airQuality: Colors.orange};
      }
    }
    return {airQuality: Colors.green};
  }

  Widget _cardMenu({
    required BuildContext context,
    required String title,
    required String reading,
    required String level,
    required double percent,
    Color color = Colors.white,
    Color fontColor = const Color.fromARGB(255, 107, 107, 107),
  }) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
          ),
          width: 150,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 7,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
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
                progressColor: const Color(0xff45A1B6),
                center: Text(
                  reading.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (title != 'المركبات العضوية المتطايرة')
                const SizedBox(height: 24),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: fontColor),
                        textAlign: TextAlign.center,
                        //softWrap: true,
                      ),
                    ),
                    if (title != 'المركبات العضوية المتطايرة')
                      const SizedBox(height: 12),
                  ],
                ),
              ),
              Text(
                level,
                style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
              ),
            ],
          ),
        ),
        if (title == 'ثاني أكسيد الكربون')
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: myWidget(context, 1),
          ),
        if (title == 'المركبات العضوية المتطايرة')
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: myWidget(context, 2),
          ),
      ],
    );
  }

  Widget myWidget(BuildContext context, int type) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          builder: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CO2
                if (type == 1)
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'يمكن أن تؤثر المستويات العالية من ثاني أكسيد الكربون في الهواء الداخلي سلبًا على جودة الهواء وقد تضر بصحة الإنسان. \n تشمل الأعراض الشائعة المرتبطة بارتفاع مستويات ثاني أكسيد الكربون الصداع والتعب والغثيان والإغماء.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                //TVOC
                if (type == 2)
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'المركبات العضوية المتطايرة هي  مواد كيميائية عضوية من الممكن أن تؤثر سلبًا على جودة الهواء وقد تضر بصحة الإنسان.\nتشمل الأعراض المرتبطة بارتفاع مستويات إجمالي المركبات العضوية المتطايرة الصداع والتعب ومشاكل الجهاز التنفسي.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'حسناً',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 43, 138, 159),
                  ),
                )
              ],
            ),
          ),
        );
      },
      icon: Image.asset(
        'images/question.png',
        width: 18,
        height: 18,
      ),
    );
  }
}
