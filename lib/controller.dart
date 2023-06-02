import 'package:firebase_database/firebase_database.dart';
import 'package:naqi_app/firebase.dart';
import 'package:naqi_app/fan.dart';

class Controller {
  String status = '';
  FirebaseService firebase = FirebaseService();
  Fan fan = Fan();
  // IndoorAirQuality indoorAirQuality1 = IndoorAirQuality();

  void checkAirQualityData(var co2) {
    Future<String> fanStatus = firebase.getStatus();
    fanStatus.then((value) {
      status = value;
      if ((co2 > 1000) & (status == '0')) {
        fan.turnOn();
        print('on');
      } else if ((co2 <= 1000) & (status == '1')) {
        fan.turnOff();
        print('off');
      }
    });
  }
}
