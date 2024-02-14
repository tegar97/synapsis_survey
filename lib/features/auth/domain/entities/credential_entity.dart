import 'package:equatable/equatable.dart';

class CredentialEntity extends Equatable {
  final String nik;
  final String password;
  final bool? rememberMe;

  CredentialEntity(
      {required this.nik, required this.password, required this.rememberMe});

  @override
  // TODO: implement props
  List<Object?> get props => [nik, password, rememberMe];
}
