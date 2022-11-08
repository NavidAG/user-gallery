import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:people/models/user.dart';

class UsersRepository {
  static List<User>? users;
  static int totalPages = 0;
  static Future<List<User>?> getUsers(int pageNumber) async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://reqres.in/api/users?page=$pageNumber"),
      );
      totalPages = jsonDecode(response.body)["total_pages"];
      users = (jsonDecode(response.body)["data"] as List)
          .map((e) => User.fromJson(e))
          .toList();
      print(users);
    } catch (e) {
      print(e);
    }
    return users;
  }
}
