import 'package:synapsis_survey/features/survey/domain/entities/question_entity.dart';

import 'dart:convert';

class QuestionModel extends QuestionEntity {
  const QuestionModel(
      {required super.id, required super.name, required super.question});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      question: (json['question'] as List<dynamic>)
          .map((item) => QuestionItemModel.fromJson(item))
          .toList() ,
    );
  }

  QuestionModel toEntity() {
    return QuestionModel(
      id: id,
      name: name,
      question: question.map((item) => item.toEntity()).toList(),
    );
  }
}

class QuestionItemModel extends QuestionItemEntity {
  QuestionItemModel(
      {required super.questionid,
      required super.section,
      required super.number,
      required super.type,
      required super.scoring,
      required super.questionName,
      required super.options});

  factory QuestionItemModel.fromJson(Map<String, dynamic> json) {
    return QuestionItemModel(
      questionid: json['questionid'] ?? '',
      section: json['section'] ?? '',
      number: json['number']?? '',
      type: json['type'],
      scoring: json['scoring'],
      questionName: json['question_name'] ?? '',
      options: (json['options'] as List<dynamic>?)
          ?.map((item) => OptionModel.fromJson(item))
          .toList(),
    );
  }
}

class OptionModel extends OptionEntity {
  OptionModel(
      {required super.optionid,
      required super.optionName,
      required super.points,
      required super.flag});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
        optionid: json['optionid'] ?? '',
        optionName: json['option_name'] ?? '',
        points: json['points'] ?? '',
        flag: json['flag'] ?? '');
  }
}
