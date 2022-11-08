import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:people/repositories/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequestEvent);
  }
  Future<void> _onLoginRequestEvent(
      LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());
    String? token = await LoginRepository.login(event.email, event.password);
    if (token != null) {
      emit(LoginSuccess());
      //TODO: Save token in shared preferences
    } else {
      emit(LoginFailed());
    }
  }
}
