import 'package:dartz/dartz.dart';
import 'package:synapsis_survey/core/error/failures.dart';
import 'package:synapsis_survey/features/auth/domain/repositories/auth_repository.dart';

class CheckLoginUseCase {
  final AuthRepository _repository;

  CheckLoginUseCase(this._repository);

  Future<Either<Failure, bool>> call() {
    return _repository.checkIsLogin();
  }

  
}
