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

      // check apakah data question_id sebelumnya sudah pernah ada
      if (event.isCheckbox == true &&
          state.answer
              .any((element) => element.question_id == newAnswer.question_id)) {
        // jika iya maka gabungkan data dari answer terdahulu dengan answer terbaru
        // contoh , answer : 'jawaba lama,jawaban baru'
        String mergedAnswer = state.answer
            .where((element) => element.question_id == newAnswer.question_id)
            .map((e) => e.answer)
            .toList()
            .join(', '); // Gabungkan jawaban lama dengan yang baru
        newAnswer = Answer(
            question_id: newAnswer.question_id,
            answer: '$mergedAnswer, ${newAnswer.answer}');
      }

      emit(QuetionAnswerAdded([...state.answer, newAnswer]));
    });

    on<OnUpdateQuestionAnswer>((event, emit) {
      List<Answer> answers = state.answer;
      String id = event.questionId;
      int index = answers.indexWhere((answer) => answer.question_id == id);

      if (index != -1) {
        answers[index] = event.answers;

        emit(QuestionAnswerUpdated(answers));
      }
    });
    on<OnClearQuestionAnswer>((event, emit) {
      emit(QuestionAnswerRemove([]));
    });

    on<OnRemoveCheckboxAnswer>((event, emit) {
      String id = event.questionId;

      state.answer.map((e) => {
          // List<String> answer = e.answer.
      });
      // cari answer yang questionIdnya sama dengan variabel id
      // hapus jawaban yang memilii answer sama dengan event.answer
    });
  }
}
