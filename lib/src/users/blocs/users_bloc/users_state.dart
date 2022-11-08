part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersInProgress extends UsersState {}

class UsersFetched extends UsersState {
  final List<User> users;

  const UsersFetched(this.users);
}

class UsersFailed extends UsersState {}
