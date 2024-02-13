import 'package:equatable/equatable.dart';
import 'package:synapsis_survey/features/survey/domain/entities/parcitipant_entity.dart';

class SurveyEntity extends Equatable {
  final String id;
  final String name;
  final String assessmentDate;
  final String description;
  final String type;
  final int roleAssessor;
  final String roleAssessorName;
  final int roleParticipant;
  final String roleParticipantName;
  final String departmentId;
  final String departmentName;
  final String siteLocationId;
  final String siteLocationName;
  final String image;
  final List<ParticipantEntity> participants;
  final String assessors;
  final String createdAt;
  final String updatedAt;
  final String downloadedAt;
  final bool hasResponses;

  SurveyEntity({
    required this.id,
    required this.name,
    required this.assessmentDate,
    required this.description,
    required this.type,
    required this.roleAssessor,
    required this.roleAssessorName,
    required this.roleParticipant,
    required this.roleParticipantName,
    required this.departmentId,
    required this.departmentName,
    required this.siteLocationId,
    required this.siteLocationName,
    required this.image,
    required this.participants,
    required this.assessors,
    required this.createdAt,
    required this.updatedAt,
    required this.downloadedAt,
    required this.hasResponses,
  });
 @override
  List<Object?> get props => [
        id,
        name,
        assessmentDate,
        description,
        type,
        roleAssessor,
        roleAssessorName,
        roleParticipant,
        roleParticipantName,
        departmentId,
        departmentName,
        siteLocationId,
        siteLocationName,
        image,
        participants,
        assessors,
        createdAt,
        updatedAt,
        downloadedAt,
        hasResponses,
      ];
}