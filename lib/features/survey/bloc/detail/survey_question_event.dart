part of 'survey_question_bloc.dart';

sealed class SurveyQuestionEvent extends Equatable {
  const SurveyQuestionEvent();

  @override
  List<Object> get props => [];
}


class OnGetSurveyQuestion extends SurveyQuestionEvent {
   final String surveyId;

  const OnGetSurveyQuestion(this.surveyId);

  @override
  List<Object> get props => [surveyId];
}