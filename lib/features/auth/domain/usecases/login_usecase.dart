import 'package:dartz/dartz.dart';
import 'package:synapsis_survey/core/error/failures.dart';
import 'package:synapsis_survey/features/auth/domain/entities/user_entitiy.dart';
import 'package:synapsis_survey/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(
      {required String nik, required String password}) {
    return _repository.login(nik, password);
  }
}
