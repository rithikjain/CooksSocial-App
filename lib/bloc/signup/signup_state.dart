part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  List<Object> get props => null;
}

class InitialSignupState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessfulState extends SignupState {
  final User user;
  SignupSuccessfulState({@required this.user});
}

class SignupFailedState extends SignupState {
  final String message;
  SignupFailedState({@required this.message});
}