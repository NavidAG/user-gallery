part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersRequested extends UsersEvent {
  final int pageNumber;

  const UsersRequested(this.pageNumber);
}
