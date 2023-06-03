import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  //DatabaseReference databaseRef;
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyAGL08HmIE1Rdw8AXu9R3fo2WP2qJkQebE',
        appId: '1:737896249852:android:d517b291008da9cd35da79',
        messagingSenderId: '737896249852',
        projectId: 'fairbase-naqi-app',
        databaseURL: 'https://fairbase-naqi-app-default-rtdb.firebaseio.com',
      ),
    );
  }

  Future<String> getStatus() async {
    String status = '';
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Fan/Status').get();
    if (snapshot.exists) {
      status = snapshot.value.toString();
    } else {
      print('No data available.');
    }
    return status;
  }
}
