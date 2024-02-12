import 'package:synapsis_survey/features/auth/domain/entities/user_entitiy.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.userId,
      required super.nik,
      required super.systemRoleId,
      required super.systemRole,
      required super.name,
      required super.email,
      required super.phone,
      required super.departementId,
      required super.departement,
      required super.siteLocationId,
      required super.siteLocation});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      nik: json['nik'],
      systemRoleId: json['system_role_id'],
      systemRole: json['system_role'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      departementId: json['departement_id'],
      departement: json['departement'],
      siteLocationId: json['site_location_id'],
      siteLocation: json['site_location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'nik': nik,
      'system_role_id': systemRoleId,
      'system_role': systemRole,
      'name': name,
      'email': email,
      'phone': phone,
      'departement_id': departementId,
      'departement': departement,
      'site_location_id': siteLocationId,
      'site_location': siteLocation,
    };
  }

  UserEntity get toEntity => UserEntity(
        userId: userId,
        nik: nik,
        systemRoleId: systemRoleId,
        systemRole: systemRole,
        name: name,
        email: email,
        phone: phone,
        departementId: departementId,
        departement: departement ,
        siteLocationId: siteLocationId,
        siteLocation: siteLocation,
      );
}
