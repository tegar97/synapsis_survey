part of 'survey_bloc.dart';

sealed class SurveyState extends Equatable {
  const SurveyState();

  @override
  List<Object> get props => [];
}

final class SurveyInitial extends SurveyState {}

final class SurveyLoading extends SurveyState {}

final class SurveyFailure extends SurveyState {
  final String message;

  const SurveyFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class SurveryLoaded extends SurveyState {
  final List<SurveyEntity> data;

  const SurveryLoaded(this.data);

  @override
  List<Object> get props => [data];
}
