import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synapsis_survey/features/auth/domain/entities/user_anwser.entity.dart';

part 'question_answer_event.dart';
part 'question_answer_state.dart';

class QuestionAnswerBloc
    extends Bloc<QuestionAnswerEvent, QuestionAnswerState> {
  QuestionAnswerBloc() : super(QuestionAnswerInitial([])) {
    on<OnAddQuestionAnswer>((event, emit) {
      emit(QuestionAnswerLoading(state.answer));
      print(state.answer);

      Answer newAnswer = event.answer;
      emit(QuetionAnswerAdded([...state.answer, newAnswer]));
    });

    on<OnUpdateQuestionAnswer>((event, emit) {
      List<Answer> answers = state.answer;
      String id = event.questionId;
      // Mencari index dari jawaban yang akan diupdate
      int index = answers.indexWhere((answer) => answer.question_id == id);

      // Jika jawaban ditemukan
      if (index != -1) {
        // Mengganti jawaban pada index tersebut
        answers[index] = event.answers;

        // Mengupdate state dengan jawaban yang telah diupdate
        emit(QuestionAnswerUpdated(answers));
      }
    });
    on<OnClearQuestionAnswer>((event, emit) {
      emit(QuestionAnswerRemove([]));
    });
  }
}
