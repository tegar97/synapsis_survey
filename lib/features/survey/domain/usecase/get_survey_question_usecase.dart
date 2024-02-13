import 'package:dartz/dartz.dart';
import 'package:synapsis_survey/core/error/failures.dart';
import 'package:synapsis_survey/features/survey/domain/entities/question_entity.dart';
import 'package:synapsis_survey/features/survey/domain/repositories/survey_repository.dart';

class GetSurveyQuestionUseCase{
  final SurveyRepository _repository;

  GetSurveyQuestionUseCase(this._repository);

  Future<Either<Failure,QuestionEntity>> call(String surveyId){
    return _repository.getSurveyQuestion(surveyId);
  }
}