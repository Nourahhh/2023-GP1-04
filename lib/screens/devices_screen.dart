import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqi_app/firebase.dart';
import 'package:naqi_app/screens/home_screen.dart';
import 'package:naqi_app/screens/signup_screen.dart';

class DevicesPage extends StatefulWidget {
  DevicesPage({Key? key}) : super(key: key);

  @override
  _DevicesPageState createState() => _DevicesPageState();
}

SignupScreen signupscreen = SignupScreen();

class _DevicesPageState extends State<DevicesPage> {
  String indoorSensorId = '';
  String outdoorSensorId = '';

  bool hasIndoorSensor = false;
  bool hasOutdoorSensor = false;

  bool isLoading = false;
  String errorMessage = '';

  String IndoorButtonText = "توصيل المستشعر الداخلي";
  String OutdoorButtonText = "توصيل المستشعر الخارجي";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          toolbarHeight: 200,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                  ),
                  Spacer(),
                ],
              ),
              Image.asset(
                'images/IMG_1270.jpg',
                width: 160,
                height: 160,
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'توصيل المستشعرات',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Text(
                      'معرف المستشعر الداخلي',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // Replace with the desired icon
                    SizedBox(
                        width:
                            5), // Adjust the spacing between the icon and text

                    infoWidget(
                        context,
                        "تستطيع إيجاد المعرف على المستشعر في الأسفل",
                        'images/IMG_1270.jpg'),
                  ],
                ),
                SizedBox(height: 8.0),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      indoorSensorId = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'أدخل معرف المستشعر الداخلي',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff45A1B6),
                    ), // Set the background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 255, 255, 255),
                    ), // Set the text color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set the border radius
                      ),
                    ),
                  ),
                  onPressed: isLoading ? null : connectIndoorSensor,
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Center(
                          child: Text(IndoorButtonText),
                        ),
                ),
                SizedBox(height: 40.0),
                Row(
                  children: [
                    Text(
                      'معرف المستشعر الخارجي',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // Replace with the desired icon
                    SizedBox(
                        width:
                            5), // Adjust the spacing between the icon and text

                    infoWidget(
                        context,
                        "تستطيع إيجاد المعرف على المستشعر في الأسفل",
                        'images/IMG_1270.jpg'),
                  ],
                ),
                SizedBox(height: 8.0),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      outdoorSensorId = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'أدخل معرف الحساس الخارجي',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff45A1B6),
                    ), // Set the background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 255, 255, 255),
                    ), // Set the text color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set the border radius
                      ),
                    ),
                  ),
                  onPressed: isLoading ? null : connectOutdoorSensor,
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Center(
                          child: Text(OutdoorButtonText),
                        ),
                ),
                SizedBox(height: 16.0),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                    ),
                  ),
                ElevatedButton.icon(
                  onPressed: (hasIndoorSensor && hasOutdoorSensor)
                      ? () => navigateToIndoorAirQualityPage(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 84, 185, 146),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Adjust the border radius
                    ),
                  ),
                  icon: Icon(
                    Icons
                        .check_circle, // Replace with a different icon if desired
                    size: 35, // Adjust the icon size
                  ),
                  label: Text(
                    'تم',
                    style: TextStyle(
                      fontSize: 25, // Adjust the font size
                      fontWeight:
                          FontWeight.bold, // Apply a different font weight
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void connectIndoorSensor() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    // Check if the indoor sensor ID exists in the sensor table
    //DocumentSnapshot sensorSnapshot = await FirebaseFirestore.instance
    //  .collection('Sensor')
    //.doc(indoorSensorId)
    //.get();

    final QuerySnapshot sensorSnapshot = await FirebaseFirestore.instance
        .collection('Sensor')
        .where('SensorID', isEqualTo: indoorSensorId)
        .where('Type', isEqualTo: 'I')
        .limit(1)
        .get();

    if (sensorSnapshot.docs.isNotEmpty) {
      // Connect the user with the indoor sensor by adding the sensor ID to the user table
      //await FirebaseFirestore.instance
      //    .collection('users')
      //    .doc('user_id') // Replace 'user_id' with the actual user ID
      //    .update({'indoorSensorId': indoorSensorId});
      updateInfo('IndoorSensorID', indoorSensorId);
      setState(() {
        hasIndoorSensor = true;
        isLoading = false;
        IndoorButtonText = 'تم التوصيل بنجاح';
      });
    } else {
      setState(() {
        errorMessage = 'معرف المستشعر الداخلي خاطئ';
        isLoading = false;
      });
    }
  }

  void connectOutdoorSensor() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    // Check if the outdoor sensor ID exists in the sensor table
    //DocumentSnapshot sensorSnapshot = await FirebaseFirestore.instance
    //    .collection('sensors')
    //    .doc(outdoorSensorId)
    //   .get();

    // if (sensorSnapshot.exists) {
    final QuerySnapshot sensorSnapshot = await FirebaseFirestore.instance
        .collection('Sensor')
        .where('SensorID', isEqualTo: outdoorSensorId)
        .where('Type', isEqualTo: 'O')
        .limit(1)
        .get();

    if (sensorSnapshot.docs.isNotEmpty) {
      // Connect the user with the outdoor sensor by adding the sensor ID to the user table
      //await FirebaseFirestore.instance
      //    .collection('users')
      //    .doc('user_id') // Replace 'user_id' with the actual user ID
      //  .update({'outdoorSensorId': outdoorSensorId});
      updateInfo('OutdoorSensorID', outdoorSensorId);

      setState(() {
        hasOutdoorSensor = true;
        isLoading = false;
        OutdoorButtonText = 'تم التوصيل بنجاح';
      });
    } else {
      setState(() {
        errorMessage = 'معرف المستشعر الخارجي خاطئ';
        isLoading = false;
      });
    }
  }

  //void navigateToIndoorAirQualityPage() {
  // Navigate to the Indoor Air Quality page
  //}

  void navigateToIndoorAirQualityPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeSceen()),
    );
  }

  //
  void updateInfo(var feild, var feildValue) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({feild: feildValue});
      setState(() {
        feild = feildValue;
      });
    }
  }
}

Widget infoWidget(BuildContext context, String text, String imageUrl) {
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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Image.asset(
                      imageUrl,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                    ),
                  ],
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
    icon: Icon(
      Icons.info_outline,
      size: 14,
      color: Color.fromARGB(255, 107, 107, 107),
    ),
  );
}
