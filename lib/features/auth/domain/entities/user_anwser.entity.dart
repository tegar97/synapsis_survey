import 'package:equatable/equatable.dart';

class UserAnswer extends Equatable {
  final String surveyId;
  final List<Answer> answer;

  UserAnswer({
    required this.surveyId,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      'survey_id': surveyId,
      'answer': answer,
    };
  }

  @override
  List<Object?> get props => [surveyId,  answer];
}

class Answer {
  final String question_id;
  final String answer;

  Answer({required this.question_id, required this.answer});

  Map<String, dynamic> toJson() {
    return {
      'question_id': question_id,
      'answer': answer,
    };
  }
}
