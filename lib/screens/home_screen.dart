import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({super.key});

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('مرحبا لقد تم تسجيل دخولك ',
          style: TextStyle(fontSize: 22),
          ),
          MaterialButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            color: Colors.amber,
            child: Text('تسجيل الخروج'),
            )
        ],
        
      ),

      ),
    );
  }
}