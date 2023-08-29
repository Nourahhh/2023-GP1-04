import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naqi_app/screens/indoor_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:naqi_app/screens/profile_screen.dart';

class HomeSceen extends StatefulWidget {
  const HomeSceen({super.key});

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  profilePage ProfilePage = profilePage();
  IndoorPage indoorPage = IndoorPage();

  int index = 1;
  late final pages = [
    //هنا صفحة حسابي
    ProfilePage,
    //هنا صفحة داخلي
    indoorPage,
    //هنا صفحة خارجي
    Center(child: Text('خارجي', style: TextStyle(fontSize: 37))),
    //هنا صفحة التقارير
    Center(child: Text('التقارير', style: TextStyle(fontSize: 37))),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: Image.asset(
            'images/IMG_1270.jpg',
            fit: BoxFit.fitWidth,
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
          ),
          automaticallyImplyLeading: false,
        ),
        body: pages[index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          height: 60,
          destinations: [
            NavigationDestination(
              icon: Container(
                height: 30,
                child: Image.asset(
                  'images/profile.png',
                  height: 30,
                ),
              ),
              label: "حسابي",
              selectedIcon: Container(
                height: 30,
                child: Image.asset(
                  'images/profile1.png',
                  height: 30,
                ),
              ),
            ),
            NavigationDestination(
              icon: Container(
                height: 30,
                child: Image.asset(
                  'images/indoor.png',
                  height: 30,
                ),
              ),
              label: "داخلي",
              selectedIcon: Container(
                height: 30,
                child: Image.asset(
                  'images/indoor1.png',
                  height: 30,
                ),
              ),
            ),
            NavigationDestination(
              icon: Container(
                height: 30,
                child: Image.asset(
                  'images/outdoor.png',
                  height: 30,
                ),
              ),
              label: "خارجي",
              selectedIcon: Container(
                height: 30,
                child: Image.asset(
                  'images/outdoor1.png',
                  height: 30,
                ),
              ),
            ),
            NavigationDestination(
              icon: Container(
                height: 30,
                child: Image.asset(
                  'images/report.png',
                  height: 30,
                ),
              ),
              label: "التقارير",
              selectedIcon: Container(
                height: 30,
                child: Image.asset(
                  'images/report1.png',
                  height: 30,
                ),
              ),
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
