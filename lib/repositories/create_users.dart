import 'dart:convert';

import 'package:http/http.dart' as http;

class CreateUser {
  static createNewUser(String name) async {
    try {
      http.Response response = await http
          .post(Uri.parse("https://reqres.in/api/users"), body: {"name": name});

      print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
