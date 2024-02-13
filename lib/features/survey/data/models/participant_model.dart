import 'package:synapsis_survey/features/survey/domain/entities/parcitipant_entity.dart';

class ParticipantModel extends ParticipantEntity {
  ParticipantModel(
      {required super.nik,
      required super.name,
      required super.department,
      required super.departmentId,
      required super.role,
      required super.roleId,
      required super.siteLocation,
      required super.siteLocationId,
      required super.totalAssessment,
      required super.lastAssessment,
      required super.imageProfile,
      required super.createdAt});

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      nik: json['nik'],
      name: json['name'],
      department: json['departement'],
      departmentId: json['departement_id'],
      role: json['role'],
      roleId: json['role_id'],
      siteLocation: json['site_location'],
      siteLocationId: json['site_location_id'],
      totalAssessment: json['total_assessment'],
      lastAssessment: DateTime.parse(json['last_assessment']),
      imageProfile: json['image_profile'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  ParticipantEntity toEntity() {
    return ParticipantEntity(
      nik: nik,
      name: name,
      department: department,
      departmentId: departmentId,
      role: role,
      roleId: roleId,
      siteLocation: siteLocation,
      siteLocationId: siteLocationId,
      totalAssessment: totalAssessment,
      lastAssessment: lastAssessment,
      imageProfile: imageProfile,
      createdAt: createdAt,
    );
  }
}
