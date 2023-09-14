import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqi_app/firebase.dart';
//import 'package:naqi_app/indoorAirQuality.dart';

class profilePage extends StatefulWidget {
  profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  //IndoorAirQuality indoorAirQuality = IndoorAirQuality();
  String originalFirstName = FirebaseService.first_name ?? "";
  String originalLastName = FirebaseService.last_name ?? "";
  bool changesMade = false; // Add a boolean variable to track changes
  bool isButtonEnabled = false; // Add a boolean variable to track button state

  @override
  void initState() {
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الاسم الأول',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                          height:
                              5), // Adjusted the SizedBox height for better spacing

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // Simplified BorderRadius
                        ),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: TextFormField(
                            initialValue:
                                originalFirstName, // Use the original value
                            onChanged: (newValue) {
                              setState(() {
                                originalFirstName =
                                    newValue; // Update the original value locally
                                changesMade =
                                    true; // Set changesMade to true when changes are made
                                isButtonEnabled = true;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none, // Hide the underline
                            ),
                            textDirection: TextDirection
                                .rtl, // Force right-to-left direction
                            textAlign:
                                TextAlign.start, // Align to the start (left)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الاسم الأخير',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                          height:
                              5), // Adjusted the SizedBox height for better spacing

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // Simplified BorderRadius
                        ),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: TextFormField(
                            initialValue:
                                originalLastName, // Use the original value
                            onChanged: (newValue) {
                              setState(() {
                                originalLastName =
                                    newValue; // Update the original value locally
                                changesMade =
                                    true; // Set changesMade to true when changes are made
                                isButtonEnabled = true;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none, // Hide the underline
                            ),
                            textDirection: TextDirection
                                .rtl, // Force right-to-left direction
                            textAlign:
                                TextAlign.start, // Align to the start (left)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('البريد الإلكتروني',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.email),
                          title: Text(
                            FirebaseService.email ?? "",
                            style: TextStyle(
                              color: Colors
                                  .grey[600], // Set the color to dark grey
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                // Adjusted the SizedBox height for better spacing
                ElevatedButton(
                  onPressed:
                      isButtonEnabled // Enable the button based on the isButtonEnabled variable
                          ? () {
                              if (originalFirstName != null &&
                                  originalFirstName.isNotEmpty) {
                                FirebaseService.first_name = originalFirstName;
                                updateInfo('firstName', originalFirstName);
                              }

                              if (originalLastName != null &&
                                  originalLastName.isNotEmpty) {
                                FirebaseService.last_name = originalLastName;
                                updateInfo('lastName', originalLastName);
                              }

                              // After updating Firestore, show a success message
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  isButtonEnabled =
                                      false; // Disable the button when the dialog is displayed
                                  return AlertDialog(
                                    title: Text(
                                        'تم الحفظ بنجاح'), // Success message in Arabic
                                    content: Text(
                                        'تم حفظ التغييرات بنجاح.'), // Success message in Arabic
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          isButtonEnabled =
                                              true; // Enable the button after closing the dialog
                                        },
                                        style: TextButton.styleFrom(
                                          primary: Colors
                                              .blue, // Set the text color of the OK button to blue
                                        ),
                                        child: Text(
                                            'حسنًا'), // OK button in Arabic
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          : null, // Set onPressed to null to disable the button when it's not enabled
                  child: Text(
                    'حفظ التغييرات', // Button text in Arabic
                    style: TextStyle(
                      color: isButtonEnabled
                          ? Colors.white
                          : Colors.grey[700], // Conditional text color
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 43, 138, 159),
                    // Set the background color of the button
                     shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
         // Adjust the radius to match the container
      ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
