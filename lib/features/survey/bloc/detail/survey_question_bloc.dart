import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synapsis_survey/features/survey/bloc/detail/survey_question_state.dart';
import 'package:synapsis_survey/features/survey/domain/usecase/get_all_survey_usecase.dart';
import 'package:synapsis_survey/features/survey/domain/usecase/get_survey_question_usecase.dart';

part 'survey_question_event.dart';

class SurveyQuestionBloc extends Bloc<SurveyQuestionEvent, SurveyQuestionState> {
   final GetSurveyQuestionUseCase _useCase;

  SurveyQuestionBloc(this._useCase) : super(SurveyQuestionInitial()) {
    on<OnGetSurveyQuestion>((event, emit) async {
        emit(SurveyQuestionLoading());
      final result = await _useCase(event.surveyId);
      result.fold((failure) => emit(SurveyQuestionFailure(failure.message)),
          (data) => emit(SurveyQuestionLoaded(data)));
    });
  }
}
