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
  final uuid = Uuid();

  UsersFetched(this.users);
  List<Object> get props => [uuid];
}

class UsersFailed extends UsersState {}
