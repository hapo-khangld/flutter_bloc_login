part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.userName);

  final String userName;

  @override
  List<Object> get props => [userName];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.passWord);

  final String passWord;

  @override
  List<Object> get props => [passWord];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
