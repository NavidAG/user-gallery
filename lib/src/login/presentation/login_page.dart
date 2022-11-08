import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:people/repositories/login_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/src/login/login_bloc/login_bloc.dart';
import 'package:people/src/users/users_page.dart';

/// This page is responsible for Login Page
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc loginBloc = LoginBloc();

  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController passwordTextEditingController =
      TextEditingController();
  bool submitButtonIsActive = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => loginBloc,
        child: Scaffold(
          appBar: AppBar(title: Text(AppLocalizations.of(context)!.appTitle)),
          body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UsersPage()));
              }
            },
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                TextField(
                  onChanged: (value) => _textfieldOnChanged(),
                  controller: emailTextEditingController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                  ),
                ),
                TextField(
                  onChanged: (value) => _textfieldOnChanged(),
                  controller: passwordTextEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                  ),
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginFailed) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(AppLocalizations.of(context)!.loginFailed,
                            style: TextStyle(color: Colors.red)),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginInProgress) {
                      return const Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ElevatedButton(
                          onPressed: submitButtonIsActive
                              ? () {
                                  loginBloc.add(LoginRequested(
                                      email: emailTextEditingController.text,
                                      password:
                                          passwordTextEditingController.text));
                                }
                              : null,
                          child: Text(
                            AppLocalizations.of(context)!.login,
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }

  void _textfieldOnChanged() {
    setState(() {
      submitButtonIsActive = emailTextEditingController.text.isNotEmpty &&
          passwordTextEditingController.text.isNotEmpty;
    });
  }
}
