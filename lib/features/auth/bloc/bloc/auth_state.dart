part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthLoaded extends AuthState {
  final UserEntity userData;

  const AuthLoaded(this.userData);

  @override
  List<Object> get props => [userData];
}


final class AuthCookie extends AuthState{

  final bool isLogin;

  const AuthCookie(this.isLogin);
  @override
  List<Object> get props => [isLogin];


}