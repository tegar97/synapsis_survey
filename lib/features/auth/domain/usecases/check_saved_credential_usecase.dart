
import 'package:dartz/dartz.dart';
import 'package:synapsis_survey/core/error/failures.dart';
import 'package:synapsis_survey/features/auth/domain/entities/credential_entity.dart';
import 'package:synapsis_survey/features/auth/domain/repositories/auth_repository.dart';

class CheckSavedCredentialUsecase {
 final AuthRepository _repository;

  CheckSavedCredentialUsecase(this._repository);

  Future<Either<Failure, CredentialEntity?>> call() {
    return _repository.checkSavedCredential();
  }

}