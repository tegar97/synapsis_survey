import 'package:equatable/equatable.dart';
import 'package:synapsis_survey/features/survey/domain/entities/question_entity.dart';



sealed class SurveyQuestionState extends Equatable {
  const SurveyQuestionState();
  
  @override
  List<Object> get props => [];
}

final class SurveyQuestionInitial extends SurveyQuestionState {}
final class SurveyQuestionLoading extends SurveyQuestionState {}

final class SurveyQuestionFailure extends SurveyQuestionState {
  final String message;

  const SurveyQuestionFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class SurveyQuestionLoaded extends SurveyQuestionState {
  final QuestionEntity data;

  const SurveyQuestionLoaded(this.data);

  @override
  List<Object> get props => [data];
}
