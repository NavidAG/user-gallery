import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:people/repositories/users_repository.dart';
import 'package:people/src/users/blocs/users_bloc/users_bloc.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  final UsersBloc usersBloc = UsersBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => usersBloc..add(UsersRequested(1)),
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.users),
          ),
          body: BlocBuilder<UsersBloc, UsersState>(
            builder: (context, state) {
              if (state is UsersFetched) {
                return ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        title: Text(
                            "${state.users[index].firstName} ${state.users[index].lastName}"),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            state.users[index].avatar,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                      );
                    }));
              } else {
                return const Center(
                  child: Text("No Users"),
                );
              }
            },
          )),
    );
  }
}
