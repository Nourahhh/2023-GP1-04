import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqi_app/firebase.dart';
import 'package:naqi_app/indoorAirQuality.dart';

class profilePage extends StatefulWidget {
  profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  IndoorAirQuality indoorAirQuality = IndoorAirQuality();
  var newValue1;
  var newValue2;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text(
                  'المعلومات الشخصية',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
                          SizedBox(height: 1),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text(FirebaseService.first_name ?? ""),
                              trailing: Icon(Icons.edit),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('تعديل الاسم الأول'),
                                    content: TextField(
                                      controller: TextEditingController(
                                          text: FirebaseService.first_name),
                                      onChanged: (value) {
                                        setState(() {
                                          newValue1 = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'الاسم الأول',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'إلغاء',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (newValue1 != null &&
                                              newValue1.isNotEmpty) {
                                            updateInfo('firstName', newValue1);
                                            FirebaseService.first_name =
                                                newValue1;
                                          }
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'حفظ',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
                          SizedBox(height: 1),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text(FirebaseService.last_name ?? ""),
                              trailing: Icon(Icons.edit),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('تعديل الاسم الأخير'),
                                    content: TextField(
                                      controller: TextEditingController(
                                          text: FirebaseService.last_name),
                                      onChanged: (value) {
                                        setState(() {
                                          newValue2 = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'الاسم الأخير',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'إلغاء',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (newValue2 != null &&
                                              newValue2.isNotEmpty) {
                                            updateInfo('lastName', newValue2);
                                            FirebaseService.last_name =
                                                newValue2;
                                          }
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'حفظ',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('البريد الإلكتروني',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 1),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
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
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 20),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('رسالة تأكيد'),
                              content: Text('هل تريد بالفعل تسجيل الخروج؟'),
                              actions: [
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
        )),
      ),
    );
  }
}
