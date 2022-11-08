import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:people/models/user.dart';

class UserDetailPage extends StatelessWidget {
  final User user;
  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white12,
        iconTheme: const IconThemeData(color: Colors.teal),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(user.avatar),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "${user.firstName} ${user.lastName}",
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                user.email,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Color.fromARGB(142, 0, 73, 66)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
