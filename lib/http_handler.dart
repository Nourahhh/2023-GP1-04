import 'dart:async';
import 'package:http/http.dart' as http;

class HTTPHandler {
  Stream<String> getReadings() =>
      Stream.periodic(Duration(seconds: 3)).asyncMap((_) => getReading());

  Future<String> getReading() async {
    final url =
        'https://webhook.site/token/0b3900cf-79d5-4c94-968c-8f8003fb1c6f/request/latest/raw';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("ok");
      return response.body.toString();
    } else {
      print("Connection Error");
      throw Exception("faild");
    }
  }
}
