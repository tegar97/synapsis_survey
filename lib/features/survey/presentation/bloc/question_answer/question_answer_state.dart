part of 'question_answer_bloc.dart';

sealed class QuestionAnswerState extends Equatable {
  final List<Answer> answer;

  const QuestionAnswerState(this.answer);

  @override
  List<Object> get props => [answer];
}

final class QuestionAnswerInitial extends QuestionAnswerState {
  const QuestionAnswerInitial(super.answer);
}

final class QuestionAnswerLoading extends QuestionAnswerState {
  const QuestionAnswerLoading(super.answer);
}

final class QuetionAnswerAdded extends QuestionAnswerState {
  const QuetionAnswerAdded(super.answer);
}

final class QuestionAnswerUpdated extends QuestionAnswerState {
  const QuestionAnswerUpdated(super.answer);
}


final class QuestionAnswerRemove extends QuestionAnswerState {
  const QuestionAnswerRemove(super.answer);
}
