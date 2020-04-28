part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessfulState extends LoginState {
  final User user;
  LoginSuccessfulState({@required this.user});
}

class LoginFailedState extends LoginState {
  final String message;
  LoginFailedState({@required this.message});
}
