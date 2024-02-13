import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synapsis_survey/features/auth/domain/entities/user_entitiy.dart';
import 'package:synapsis_survey/features/survey/domain/entities/survey_entity.dart';
import 'package:synapsis_survey/features/survey/domain/usecase/get_all_survey_usecase.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final GetAllSurveyUseCase _useCase;

  SurveyBloc(this._useCase) : super(SurveyInitial()) {
    on<OnGetAllSurvey>((event, emit) async {
      emit(SurveyLoading());
      final result = await _useCase();
      result.fold((failure) => emit(SurveyFailure(failure.message)),
          (data) => emit(SurveryLoaded(data)));
    });
  }
}
