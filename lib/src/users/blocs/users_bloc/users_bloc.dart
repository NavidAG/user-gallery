import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:people/models/user.dart';
import 'package:people/repositories/users_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<UsersRequested>(_onUsersRequestedEvent);
  }
  Future<void> _onUsersRequestedEvent(
      UsersRequested event, Emitter<UsersState> emit) async {
    emit(UsersInProgress());
    List<User>? users = await UsersRepository.getUsers(event.pageNumber);
    if (users != null) {
      emit(UsersFetched(users));
    } else {
      emit(UsersFailed());
    }
  }
}
