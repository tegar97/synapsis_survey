part of 'question_answer_bloc.dart';

sealed class QuestionAnswerEvent extends Equatable {
  const QuestionAnswerEvent();

  @override
  List<Object> get props => [];
}

class OnAddQuestionAnswer extends QuestionAnswerEvent {
  final Answer answer;
  final bool isCheckbox;

  const OnAddQuestionAnswer(this.answer, this.isCheckbox);
}

class OnUpdateQuestionAnswer extends QuestionAnswerEvent {
  final String questionId;
  final Answer answers;

  OnUpdateQuestionAnswer(this.questionId, this.answers);

  @override
  List<Object> get props => [questionId, answers];
}

class OnClearQuestionAnswer extends QuestionAnswerEvent {}

class OnRemoveCheckboxAnswer extends QuestionAnswerEvent {
  final String questionId;
  final Answer answers;

  OnRemoveCheckboxAnswer(this.questionId,this.answers);
  @override
  List<Object> get props => [questionId,answers];

}
