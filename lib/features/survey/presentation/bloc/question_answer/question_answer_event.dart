part of 'question_answer_bloc.dart';

sealed class QuestionAnswerEvent extends Equatable {
  
  const QuestionAnswerEvent();

  @override
  List<Object> get props => [];
}

class OnAddQuestionAnswer extends QuestionAnswerEvent {
  final Answer answer;

  const OnAddQuestionAnswer(this.answer);
}

class OnUpdateQuestionAnswer extends QuestionAnswerEvent {
  final String questionId;
  final Answer answers;

  OnUpdateQuestionAnswer(this.questionId, this.answers);

  @override
  List<Object> get props => [questionId, answers];
}


class OnClearQuestionAnswer extends QuestionAnswerEvent {
 
}