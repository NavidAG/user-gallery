import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:people/models/user.dart';

class UsersRepository {
  static List<User> users = [];
  static int currentPage = 1;
  static int totalPages = 1;
  static Future<List<User>> getUsers() async {
    try {
      if (totalPages >= currentPage) {
        http.Response response = await http.get(
          Uri.parse("https://reqres.in/api/users?page=$currentPage"),
        );
        totalPages = jsonDecode(response.body)["total_pages"];
        users.addAll(((jsonDecode(response.body)["data"] as List)
            .map((e) => User.fromJson(e))
            .toList()));
        print(users);
        currentPage++;
      }
    } catch (e) {
      print(e);
    }
    return users;
  }
}
