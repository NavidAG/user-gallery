import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:people/models/user.dart';
import 'package:people/src/users/widgets/add_new_user_modal.dart';
import 'package:people/src/users/user_detail_page.dart';
import 'package:people/src/users/users_bloc/users_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final UsersBloc usersBloc = UsersBloc();
  var preventCall = false;

  var scrollController = ScrollController(initialScrollOffset: 0.1);
  initState() {
    scrollController.addListener(onScroll);
    super.initState();
  }

  void onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      usersBloc.add(UsersRequested());
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    super.dispose();
    usersBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => usersBloc..add(UsersRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.users),
          actions: [
            IconButton(
                onPressed: () => _addUserModel(), icon: const Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersFetched) {
              return ListView.builder(
                controller: scrollController,
                itemCount: state.users.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    onTap: () => _listTileOnTap(context, state.users[index]),
                    title: Text(
                        "${state.users[index].firstName} ${state.users[index].lastName}"),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        state.users[index].avatar,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                  );
                }),
              );
            } else if (state is UsersInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("No Users"),
              );
            }
          },
        ),
      ),
    );
  }

  void _listTileOnTap(BuildContext context, User user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserDetailPage(
                  user: user,
                )));
  }

  void _addUserModel() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return AddNewUserModal();
      },
    );
  }
}
