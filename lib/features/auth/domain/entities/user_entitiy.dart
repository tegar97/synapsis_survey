import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String? token;
  final String nik;
  final int systemRoleId;
  final String systemRole;
  final String name;
  final String email;
  final String phone;
  final String departementId;
  final String departement;
  final String siteLocationId;
  final String siteLocation;

  const UserEntity({
    required this.userId,
    this.token,
    required this.nik,
    required this.systemRoleId,
    required this.systemRole,
    required this.name,
    required this.email,
    required this.phone,
    required this.departementId,
    required this.departement,
    required this.siteLocationId,
    required this.siteLocation,
  });

  @override
  List<Object?> get props => [
        userId,
        token,
        nik,
        systemRoleId,
        systemRole,
        name,
        email,
        phone,
        departementId,
        departement,
        siteLocationId,
        siteLocation,
      ];
}
