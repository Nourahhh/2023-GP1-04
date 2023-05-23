import 'package:http/http.dart' as http;
import 'dart:convert';

class Fan {
  String status = 'off';
  Future<void> sendDownlink(String payload) async {
    final String url =
        'https://eu1.cloud.thethings.network/api/v3/as/applications/naqi-indoor/webhooks/indoor-webhook/devices/controller/down/replace';

    Map<String, String> headers = {
      'Authorization':
          'Bearer NNSXS.PVO4DHCCM5RAEZYBF5GPSXYMXPNVMLWNDM4B3HI.5TSP2CMJXH2VHBOIUONHZ2ZX6PRKNSZK4RF3BWUM4ELAN7WPW55Q',
      'Content-Type': 'application/json',
      'User-Agent': 'my-integration/my-integration-version',
    };

    Map<String, dynamic> body = {
      'downlinks': [
        {
          'frm_payload': payload,
          'f_port': 2,
          'priority': 'NORMAL',
        }
      ],
    };

    String jsonBody = json.encode(body);
    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );
    print(response.body);
  }

  void turnOn() {
    sendDownlink('');
    status = 'on';
  }

  void turnOff() {
    sendDownlink('');
    status = 'off';
  }
}
