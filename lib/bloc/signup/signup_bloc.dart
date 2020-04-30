import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cooks_social/data/models/user.dart';
import 'package:cooks_social/data/repositories/auth_repository.dart';
import 'package:cooks_social/utils/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepository authRepository = AuthRepository();

  @override
  SignupState get initialState => InitialSignupState();

  @override
  Stream<SignupState> mapEventToState(SignupEvent event,) async* {
    if (event is SignupInitiatedEvent) {
      yield SignupLoadingState();
      try {
        var signupResponse = await authRepository.signupUser(
          formData: event.formData,
        );
        SharedPref.setUserAuthToken(signupResponse.token);
        yield SignupSuccessfulState(user: signupResponse.user);
      } catch (e) {
        yield SignupFailedState(message: e.toString());
      }
    }
  }
}
