import 'dart:async';
import 'package:http/http.dart' as http;

Future<http.Response?> getfoodbanks() async {
  return await http
      .get(Uri.parse("https://www.givefood.org.uk/api/2/foodbanks/"));
}

Future<http.Response?> getfoodbankSearchByLocation(String address) async {
  return await http.get(Uri.parse(
      "https://www.givefood.org.uk/api/2/foodbanks/search/?address=" +
          address));
}
