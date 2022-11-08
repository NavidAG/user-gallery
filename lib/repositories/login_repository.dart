import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginRepository {
  static String? token;
  static Future<String?> login(String email, String password) async {
    try {
      http.Response response = await http.post(
          Uri.parse("https://reqres.in/api/login"),
          body: {"email": email, "password": password});
      token = jsonDecode(response.body)["token"];
      print(response.body);
    } catch (e) {
      print(e);
    }
    return token;
  }
}
