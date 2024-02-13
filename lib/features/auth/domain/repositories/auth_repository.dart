import 'package:dartz/dartz.dart';
import 'package:synapsis_survey/core/error/failures.dart';
import 'package:synapsis_survey/features/auth/domain/entities/user_entitiy.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String nik, String password,bool rememberSession);
  Future<Either<Failure, bool>> checkIsLogin();

  Future<Either<Failure, void>> logout();
}
