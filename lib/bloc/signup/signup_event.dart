part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  List<Object> get props => null;
}

class SignupInitiatedEvent extends SignupEvent {
  final FormData formData;

  SignupInitiatedEvent({@required this.formData});
}
