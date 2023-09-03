//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profilePage extends StatefulWidget {
  profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  //اسوي لها رتريف من الداتابيس
  bool val = false;
  // Initial Selected Value
  String dropdownvalue = 'خفيف';

  // List of items in our dropdown menu
  var items = [
    'خفيف',
    'متوسط',
    'شديد',
  ];
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text('المعلومات الشخصية', style: TextStyle(fontSize: 25)),
          ),
          Text('الحالة الصحية', style: TextStyle(fontSize: 25)),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20),
                child: Text(
                  'هل تعاني من ظروف صحية تنفسية؟',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              /* Switch(
                activeColor: const Color.fromARGB(255, 255, 255, 255),
                activeTrackColor: const Color(0xff45A1B6),
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                value: healthStatus,
                onChanged: (value) => setState(() {
                  if (value) {
                    // اسوي لها ابديت بالداتابيس
                    healthStatus = true;
                  } else {
                    // اسوي لها ابديت بالداتابيس
                    healthStatus = false;
                  }
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Off'),
                  Switch(
                    value: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                  ),
                  Text('On'),
                ],
              ),*/
              GestureDetector(
                onTap: () {
                  setState(() {
                    val = !val;
                    //setHealthStatus(val)
                    //
                  });
                },
                child: Container(
                  width: 95,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 43, 138, 159)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 35,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: val
                                  ? Colors.white
                                  : Color.fromARGB(255, 43, 138, 159)),
                          child: Center(
                              child: Text(
                            'نعم',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: val ? Colors.black : Colors.white),
                          )),
                        ),
                        Container(
                          width: 35,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: val
                                  ? Color.fromARGB(255, 43, 138, 159)
                                  : Colors.white),
                          child: Center(
                              child: Text(
                            'لا',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: val ? Colors.white : Colors.black),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20),
                child: Text(
                  'المستوى:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              DropdownButton(
                // Initial Value
                //retrive level
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                borderRadius: BorderRadius.circular(10),
                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    //setLvel(dropdownvalue)
                  });
                },
              ),
            ],
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('رسالة تأكيد'),
                          content: Text('هل انت متأكد من رغبتك بتسجيل الخروج؟'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'نعم',
                                style: GoogleFonts.robotoCondensed(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'لا',
                                  style: GoogleFonts.robotoCondensed(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                )),
                          ],
                        ));
              },
              child: Text(
                'تسجيل الخروج',
                style: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 43, 138, 159)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
