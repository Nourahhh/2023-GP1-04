import 'package:firebase_database/firebase_database.dart';
import 'package:naqi_app/firebase.dart';
import 'package:naqi_app/fan.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:naqi_app/screens/indoor_screen.dart';

class Controller {
  String status = '';
  String isSwitchOn = '';
  FirebaseService firebase = FirebaseService();
  Fan fan = Fan();

  void checkAirQualityData(var co2) {
    // Get fan status and switch status from databse
    Future<String> fanStatus = firebase.getStatus();
    Future<String> fanSwitch = firebase.isSwitchOn();

    fanStatus.then((value) {
      status = value;
      fanSwitch.then((value) {
        isSwitchOn = value;
        // check CO2 and fan status
        if ((co2 > 1000) & (status == '0')) {
          fan.turnOn();
          sendNotification(
              "مستوى ثاني أكسيد الكربون مرتفع! سيتم تشغيل المروحة");
          // check CO2 and fan status and switch status
        } else if ((co2 <= 1000) & (status == '1') & (isSwitchOn == '0')) {
          fan.turnOff();
          sendNotification(" مستوى ثاني أكسيد الكربون جيد! سيتم ايقاف المروحة");
        }
      });
    });
  }

  sendNotification(String text) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10, channelKey: "default_channel", title: "تنبيه!", body: text),
    );
  }
}
