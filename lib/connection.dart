import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quotes/constants.dart';

class NetworkHelper {

  final String url;

  NetworkHelper(this.url);

  Future getData() async
  {
    // print('Pos1...');
    http.Response response = await http.get(Uri.parse(kAPI));
    // print('Pos2...');
    if(response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}