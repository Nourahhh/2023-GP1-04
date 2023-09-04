import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqi_app/main.dart';

class profilePage extends StatefulWidget {
  profilePage({Key? key}) : super(key: key);

  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  var newValue1;
  var newValue2;

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
  }

  void updateInfo(String feild, var feildValue) async {
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
                          title: Text(MyApp.first_name ?? ""),
                          trailing: Icon(Icons.edit),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('تعديل الاسم الأول'),
                                content: TextField(
                                  controller: TextEditingController(
                                      text: MyApp.first_name),
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
                                        MyApp.first_name = newValue1;
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
                          title: Text(MyApp.last_name ?? ""),
                          trailing: Icon(Icons.edit),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('تعديل الاسم الأخير'),
                                content: TextField(
                                  controller: TextEditingController(
                                      text: MyApp.last_name),
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
                                        MyApp.last_name = newValue2;
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
                            MyApp.email ?? "",
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
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20),
                child: Text(
                  'هل تعاني من ظروف صحية تنفسية؟',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    MyApp.healthStatus = !MyApp.healthStatus;
                    updateInfo('healthStatus', MyApp.healthStatus);
                  });
                },
                child: Container(
                  width: 85,
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
                              color: MyApp.healthStatus
                                  ? Colors.white
                                  : Color.fromARGB(255, 43, 138, 159)),
                          child: Center(
                              child: Text(
                            'نعم',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: MyApp.healthStatus
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          )),
                        ),
                        Container(
                          width: 35,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: MyApp.healthStatus
                                  ? Color.fromARGB(255, 43, 138, 159)
                                  : Colors.white),
                          child: Center(
                              child: Text(
                            'لا',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: MyApp.healthStatus
                                    ? Colors.white
                                    : Colors.black),
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
                    fontSize: 16,
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
                    child: Text(
                      items,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
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
