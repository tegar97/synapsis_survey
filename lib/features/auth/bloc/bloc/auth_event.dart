part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnAuthLogin extends AuthEvent {
  final String nik;
  final String password;

  const OnAuthLogin({required this.nik, required this.password});

  @override
  List<Object> get props => [nik, password];
}


class OnCheckIsLogin extends AuthEvent{

}

class OnLogout extends AuthEvent{}