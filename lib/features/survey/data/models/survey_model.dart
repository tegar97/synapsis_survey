import 'package:synapsis_survey/features/survey/data/models/participant_model.dart';
import 'package:synapsis_survey/features/survey/domain/entities/survey_entity.dart';

class SurveyModel extends SurveyEntity {
  SurveyModel(
      {required super.id,
      required super.name,
      required super.assessmentDate,
      required super.description,
      required super.type,
      required super.roleAssessor,
      required super.roleAssessorName,
      required super.roleParticipant,
      required super.roleParticipantName,
      required super.departmentId,
      required super.departmentName,
      required super.siteLocationId,
      required super.siteLocationName,
      required super.image,
      required super.participants,
      required super.assessors,
      required super.createdAt,
      required super.updatedAt,
      required super.downloadedAt,
      required super.hasResponses});

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      id: json['id'] ?? '',
    name: json['name'] ?? '',
    assessmentDate: json['assessment_date'] ?? '',
    description: json['description'] ?? '',
    type: json['type'] ?? '',
    roleAssessor: json['role_assessor'] ?? 0,
    roleAssessorName: json['role_assessor_name'] ?? '',
    roleParticipant: json['role_participant'] ?? 0,
    roleParticipantName: json['role_participant_name'] ?? '',
    departmentId: json['departement_id'] ?? '',
    departmentName: json['departement_name'] ?? '',
    siteLocationId: json['site_location_id'] ?? '',
    siteLocationName: json['site_location_name'] ?? '',
    image: json['image'] ?? '',
   participants: (json['participants'] as List<dynamic>? ?? [])
        .map((participantJson) =>
            ParticipantModel.fromJson(participantJson))
        .toList(),
      assessors: json['assessors'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      downloadedAt:
          json['downloaded_at'] ?? '',
      hasResponses:
          json['has_responses'] ?? '',
    );
  }

  SurveyEntity get toEntity => SurveyEntity(
        id: id,
        name: name,
        assessmentDate: assessmentDate,
        description: description,
        type: type,
        roleAssessor: roleAssessor,
        roleAssessorName: roleAssessorName,
        roleParticipant: roleParticipant,
        roleParticipantName: roleParticipantName,
        departmentId: departmentId,
        departmentName: departmentName,
        siteLocationId: siteLocationId,
        siteLocationName: siteLocationName,
        image: image,
        participants:
            participants.map((participant) => participant.toEntity()).toList(),
        assessors: assessors,
        createdAt: createdAt,
        updatedAt: updatedAt,
        downloadedAt: downloadedAt,
        hasResponses: hasResponses,
      );
}
