import 'package:dartz/dartz.dart';
import 'package:synapsis_survey/core/error/failures.dart';
import 'package:synapsis_survey/features/survey/domain/entities/survey_entity.dart';
import 'package:synapsis_survey/features/survey/domain/repositories/survey_repository.dart';

class GetAllSurveyUseCase{
  final SurveyRepository _repository;

  GetAllSurveyUseCase(this._repository);

  Future<Either<Failure,List<SurveyEntity>>> call(){
    return _repository.get();
  }
}