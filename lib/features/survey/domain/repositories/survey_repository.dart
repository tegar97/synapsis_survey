import 'package:dartz/dartz.dart';
import 'package:synapsis_survey/core/error/failures.dart';
import 'package:synapsis_survey/features/survey/data/models/question_model.dart';
import 'package:synapsis_survey/features/survey/domain/entities/question_entity.dart';
import 'package:synapsis_survey/features/survey/domain/entities/survey_entity.dart';

abstract class SurveyRepository {
  Future<Either<Failure, List<SurveyEntity>>> get();
    Future<Either<Failure, QuestionEntity>> getSurveyQuestion(String surveyId);

}
