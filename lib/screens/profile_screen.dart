import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class profilePage extends StatefulWidget {
  profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  var first_name;
  var last_name;
  var email;
  var newValue1;
  var newValue2;

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

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userInfo = await fetchUserInfo(userId);
      setState(() {
        first_name = userInfo.data()!['firstName'];
        last_name = userInfo.data()!['lastName'];
        email = userInfo.data()!['userEmail'];
      });
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserInfo(
      String userId) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final userSnapshot = await userRef.get();
    return userSnapshot;
  }

  void updateFirstName(String newFirstName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({'firstName': newFirstName});
      setState(() {
        first_name = newFirstName;
      });
    }
  }

  void updateLastName(String newLastName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({'lastName': newLastName});
      setState(() {
        last_name = newLastName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Text('المعلومات الشخصية', style: TextStyle(fontSize: 25)),
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
                          // fontWeight: FontWeight.bold,
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
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(first_name ?? ""),
                          trailing: Icon(Icons.edit),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('تعديل الاسم الأول'),
                                content: TextField(
                                  controller:
                                      TextEditingController(text: first_name),
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
                                      updateFirstName(newValue1);
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
                          // fontWeight: FontWeight.bold,
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
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(last_name ?? ""),
                          trailing: Icon(Icons.edit),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('تعديل الاسم الأخير'),
                                content: TextField(
                                  controller:
                                      TextEditingController(text: last_name),
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
                                      updateLastName(newValue2);
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
                            fontSize: 16,
                            //fontWeight: FontWeight.bold
                          )),
                      SizedBox(height: 1),
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
                            email ?? "",
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
              ],
            ),
          ),
          Divider(
            color: Colors.grey[800],
          ),
          Container(
            child: Text('الحالة الصحية', style: TextStyle(fontSize: 25)),
          ),
          Divider(
            color: Colors.grey[800], // Set the color to dark gray
          ),
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
    ));
  }
}
