part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  List<Object> get props => [];
}

class LoginInitiatedEvent extends LoginEvent {
  final String email, password;

  LoginInitiatedEvent({@required this.email, this.password});
}
