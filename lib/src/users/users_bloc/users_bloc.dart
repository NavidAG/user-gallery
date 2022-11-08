import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:people/models/user.dart';
import 'package:people/repositories/users_repository.dart';
import 'package:uuid/uuid.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<UsersRequested>(_onUsersRequestedEvent);
  }
  Future<void> _onUsersRequestedEvent(
      UsersRequested event, Emitter<UsersState> emit) async {
    if (state is UsersInitial) {
      emit(UsersInProgress());
    }
    List<User>? users = await UsersRepository.getUsers();

    emit(UsersFetched(users));
  }
}
