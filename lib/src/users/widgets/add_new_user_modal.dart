import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:people/repositories/create_users.dart';

class AddNewUserModal extends StatelessWidget {
  AddNewUserModal({super.key});
  final TextEditingController nameTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        // color: Colors.amber,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameTextEditingController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.name,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(AppLocalizations.of(context)!.add),
                  onPressed: () async {
                    await CreateUser.createNewUser(
                        nameTextEditingController.text);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
