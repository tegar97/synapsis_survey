import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synapsis_survey/features/auth/domain/entities/user_entitiy.dart';
import 'package:synapsis_survey/features/auth/domain/usecases/check_login_usecase.dart';
import 'package:synapsis_survey/features/auth/domain/usecases/login_usecase.dart';
import 'package:synapsis_survey/features/auth/domain/usecases/logout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final CheckLoginUseCase _checkLoginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(this._loginUseCase, this._checkLoginUseCase, this._logoutUseCase)
      : super(AuthInitial()) {
    on<OnAuthLogin>((event, emit) async {
      print('riggger');
      emit(AuthLoading());
      final result =
          await _loginUseCase(nik: event.nik, password: event.password);
  
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (data) => emit(AuthLoaded(data)),
      );
    });

    on<OnCheckIsLogin>((event, emit) async {
      final result = await _checkLoginUseCase.call();
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (data) => emit(AuthCookie(data)),
      );
    });

    on<OnLogout>((event, emit) async {
      await _logoutUseCase.call();
    });
  }
}
