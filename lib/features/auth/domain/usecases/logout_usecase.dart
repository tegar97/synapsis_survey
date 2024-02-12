import 'package:dartz/dartz.dart';
import 'package:synapsis_survey/core/error/failures.dart';
import 'package:synapsis_survey/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<Either<Failure, void>> call() {
    return _repository.logout();
  }
}
