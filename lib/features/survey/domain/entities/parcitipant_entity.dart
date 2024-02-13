import 'package:equatable/equatable.dart';

class ParticipantEntity extends Equatable {
  final String nik;
  final String name;
  final String department;
  final String departmentId;
  final String role;
  final int roleId;
  final String siteLocation;
  final String siteLocationId;
  final int totalAssessment;
  final DateTime lastAssessment;
  final String imageProfile;
  final DateTime createdAt;

  const ParticipantEntity({
    required this.nik,
    required this.name,
    required this.department,
    required this.departmentId,
    required this.role,
    required this.roleId,
    required this.siteLocation,
    required this.siteLocationId,
    required this.totalAssessment,
    required this.lastAssessment,
    required this.imageProfile,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        nik,
        name,
        department,
        departmentId,
        role,
        roleId,
        siteLocation,
        siteLocationId,
        totalAssessment,
        lastAssessment,
        imageProfile,
        createdAt,
      ];

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
