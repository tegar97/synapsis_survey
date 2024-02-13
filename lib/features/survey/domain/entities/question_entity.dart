import 'package:equatable/equatable.dart';
import 'package:synapsis_survey/features/survey/data/models/question_model.dart';

class QuestionEntity extends Equatable {
  final String id;
  final String name;
  final List<QuestionItemEntity> question;

  const QuestionEntity({
    required this.id,
    required this.name,
    required this.question,
  });

  @override
  List<Object?> get props => [id, name, question];
}

class QuestionItemEntity extends Equatable {
  final String questionid;
  final String section;
  final String number;
  final String type;
  final bool scoring;
  final String questionName;
  final List<OptionEntity>? options;

  QuestionItemEntity({
    required this.questionid,
    required this.section,
    required this.number,
    required this.type,
    required this.scoring,
    required this.questionName,
    required this.options,
  });

  QuestionItemModel toEntity() {
    return QuestionItemModel(
      questionid: questionid,
      section: section,
      number: number,
      type: type,
      scoring: scoring,
      questionName: questionName,
      options: options?.map((item) => item.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
        questionid,
        section,
        number,
        questionName,
        options,
      ];
}

class OptionEntity extends Equatable {
  final String optionid;
  final String optionName;
  final int points;
  final int flag;

  OptionEntity(
      {required this.optionid,
      required this.optionName,
      required this.points,
      required this.flag});

  OptionEntity toEntity() {
    return OptionEntity(
      optionid: optionid,
      optionName: optionName,
      points: points,
      flag: flag
    );
  }

  @override
  List<Object?> get props => [optionid, optionName,points,flag];
}
