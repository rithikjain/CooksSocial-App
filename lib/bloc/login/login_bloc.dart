import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cooks_social/data/models/user.dart';
import 'package:cooks_social/data/repositories/auth_repository.dart';
import 'package:cooks_social/utils/shared_pref.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository authRepository;

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginInitiatedEvent) {
      yield LoginLoadingState();
      try {
        var loginResponse = await authRepository.loginUser(event.email, event.password);
        SharedPref.setUserAuthToken(loginResponse.token);
        yield LoginSuccessfulState(user: loginResponse.user);
      } catch (e) {
        yield LoginFailedState(message: e.toString());
      }
    }
  }
}
