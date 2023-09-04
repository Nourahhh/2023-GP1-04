import 'package:flutter/material.dart';
import 'package:naqi_app/auth.dart';
import 'package:naqi_app/screens/home_screen.dart';
import 'package:naqi_app/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:naqi_app/screens/signup_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:naqi_app/fan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  Fan fan = Fan();

  fan.setUpController();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'default_channel',
          channelName: 'Basic notification',
          channelDescription: 'Notificion',
          importance: NotificationImportance.Max,
        ),
      ],
      debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static var healthStatus = false;
  static var first_name;
  static var last_name;
  static var email;

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchUserInfo(
      String userId) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final userSnapshot = await userRef.get();
    return userSnapshot;
  }

  void getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userInfo = await fetchUserInfo(userId);

      first_name = userInfo.data()!['firstName'];
      last_name = userInfo.data()!['lastName'];
      email = userInfo.data()!['userEmail'];
      healthStatus = userInfo.data()!['healthStatus'];
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getUserInfo();

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'), // arabic
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      // home: const Auth(),
      routes: {
        '/': (context) => const Auth(),
        'homeScreen': (context) => const HomeSceen(),
        'signupScreen': (context) => const SignupScreen(),
        'loginScreen': (context) => const LoginScreen(),
      },
    );
  }
}
