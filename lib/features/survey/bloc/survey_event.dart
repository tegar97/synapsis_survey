part of 'survey_bloc.dart';

sealed class SurveyEvent extends Equatable {
  const SurveyEvent();

  @override
  List<Object> get props => [];
}
class OnGetAllSurvey extends SurveyEvent {
  
}