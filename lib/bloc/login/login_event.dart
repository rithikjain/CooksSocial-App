part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  List<Object> get props => null;
}

class LoginInitiatedEvent extends LoginEvent {
  final String email, password;

  LoginInitiatedEvent({@required this.email, @required this.password});
}
