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
  IndoorPage i = IndoorPage();

  void checkAirQualityData(var co2) {
    Future<String> fanStatus = firebase.getStatus();
    Future<String> fanSwitch = firebase.isSwitchOn();

    fanStatus.then((value) {
      status = value;
      fanSwitch.then((value) {
        isSwitchOn = value;
        if ((co2 > 1000) & (status == '0')) {
          fan.turnOn();
          sendNotification();
          print('on');
        } else if ((co2 <= 1000) & (status == '1') & (isSwitchOn == '0')) {
          fan.turnOff();
          print('off');
        }
      });
    });
  }

  sendNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: "default_channel",
          title: "تنبيه!",
          body: "مستوى ثاني أكسيد الكربون مرتفع!"),
    );
  }
}
