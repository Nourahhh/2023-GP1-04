import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/cupertino.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstNameContoroller = TextEditingController();
  final _lasttNameContoroller = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  //button style
  final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
    minimumSize: Size(345, 55),
    backgroundColor: Color.fromARGB(255, 43, 138, 159),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void openLoginScreen() {
    Navigator.of(context).pushReplacementNamed('loginScreen');
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool _showText = false;
// to see password
  bool _isSourcePaasword = true;
  bool _isSourceConfirPaasword = true;

// to connection
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
    _firstNameContoroller.dispose();
    _lasttNameContoroller.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _key,
        //padding: const EdgeInsets.all(8.0),
        //child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // image
                Image.asset(
                  'images/IMG_1270.jpg',
                  height: 200,
                ),
                SizedBox(height: 20),
                //title
                Text(
                  'تسجيل',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),

                //subtitle
                Text(
                  'مرحبا! هنا يمكنك التسجيل',
                  style: GoogleFonts.robotoCondensed(fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),

                //first name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _firstNameContoroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: " الاسم الاول",
                        prefixIcon: Icon(Icons.person)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخال الاسم الاول';
                      }
                      return null;
                    },
                  ),
                ),

                //last name
                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _lasttNameContoroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: " الاسم الاخير",
                        prefixIcon: Icon(Icons.person)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ادخال الاسم الاخير';
                      }
                      return null;
                    },
                  ),
                ),

                //last name
                SizedBox(height: 10),

                // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: "البريد الالكتروني",
                        prefixIcon: Icon(Icons.email)),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'الرجاء كتابة البريد الإلكتروني ';
                      } else if ((value.isNotEmpty) &&
                          !RegExp(r'\w+@\w+\.\w+').hasMatch(value)) {
                        return "الرجاء ادخال عنوان بريد إلكتروني صالح";
                      }

                      return null;
                    },
                  ),
                ),

                SizedBox(height: 10),

                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    onTap: () {
                      setState(() {
                        _showText =
                            true; // Add a boolean variable _showText to the widget's state
                      });
                    },
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: _isSourcePaasword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: "كلمة المرور",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: togglePasswprd(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'برجاء ادخال كلمة المرور';
                      } else if (value.length < 5 ||
                          !validateStructure(value)) {
                        return 'لم تطبق جميع شروط كلمة المرور';
                      }
                      return null;
                    },
                  ),
                ),
                if (_showText) // Display the text only when _showText is true
                  Padding(
                    padding: const EdgeInsets.only(left: 77),
                    child: Text(
                      'يجب ان تحتوى كلمة المرور على:\n- ثمانية خانات تحتوي على رقم واحد على الأقل\n- أحرف كبيرة وأحرف صغيرة \n - رمز واحد على الأقل مثل@#%&*',
                      style: GoogleFonts.robotoCondensed(fontSize: 14),
                    ),
                  ),

                SizedBox(height: 7),

                //Confirm password

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: _isSourceConfirPaasword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      labelText: " تأكيد كلمة المرور",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: toggleConfirmPasswprd(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء اعادة كتابة كلمة المرور';
                      } else if (_passwordController.text.trim() !=
                          _confirmPasswordController.text.trim()) {
                        return 'كلمة المرور غير متطابقة';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 15),

                //sigup button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        child: Text(
                          'تسجيل ',
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        style: buttonPrimary,
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            var firstName = _firstNameContoroller.text.trim();
                            var listName = _lasttNameContoroller.text.trim();

                            var userEmail = _emailController.text.trim();
                            var userPassword = _passwordController.text.trim();

                            if (passwordConfirmed()) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                      email: userEmail,
                                      password: userPassword,
                                    )
                                    .then((value) => {
                                          // ignore: avoid_print
                                          print("user created"),
                                          FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(value.user!.uid)
                                              .set({
                                            'firstName': firstName,
                                            'listName': listName,
                                            'userEmail': userEmail,
                                            'healthStatus': 0,
                                          }),
                                          // ignore: avoid_print
                                          print("data added"),
                                        })
                                    .then((value) {
                                  AwesomeDialog(
                                      // width: width(context, 1),
                                      context: context,
                                      dialogType: DialogType.success,
                                      title: "",
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      autoHide: Duration(seconds: 2),
                                      body: const Text(
                                        "تم التسجيل بنجاح",
                                        style: TextStyle(fontSize: 20),
                                      )).show().then((value) {
                                    Navigator.of(context).pushNamed('/');
                                  });
                                });
                                // Navigator.of(context).pushNamed('/');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'email-already-in-use') {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("خطأ"),
                                          content: Text(
                                              "البريد الكتروني المدخل مسجل مسبقًا، الرجاء كتابة عنوان بريد الكتروني اخر"),
                                          actions: [
                                            TextButton(
                                              child: Text("حسنًا"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });
                                }
                              }
                            }
                          }
                        }),
                  ],
                ),

                SizedBox(height: 25),

                // text sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لديك حساب بالفعل؟ ',
                      style: GoogleFonts.robotoCondensed(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: openLoginScreen,
                      child: Text(
                        'تسجيل الدخول',
                        style: GoogleFonts.robotoCondensed(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget togglePasswprd() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSourcePaasword = !_isSourcePaasword;
        });
      },
      icon: _isSourcePaasword
          ? Icon(Icons.visibility)
          : Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }

  Widget toggleConfirmPasswprd() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSourceConfirPaasword = !_isSourceConfirPaasword;
        });
      },
      icon: _isSourceConfirPaasword
          ? Icon(Icons.visibility)
          : Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext content) => CupertinoAlertDialog(
          title: Text('لا يوجد اتصال بالانترنت'),
          content: Text("الرجاء التحقق من اتصال الانترنت"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: Text('حسنا'),
            ),
          ],
        ),
      );
}
