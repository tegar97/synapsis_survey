import 'dart:convert';

import 'package:synapsis_survey/features/auth/data/models/user_model.dart';
import 'package:synapsis_survey/features/auth/domain/entities/credential_entity.dart';
import 'package:synapsis_survey/features/auth/domain/entities/user_entitiy.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> isLogin();
  Future<void> logout();
  Future<void> credentialSave(String nik, String password);
  Future<void> removeCredential();
  Future<CredentialEntity?> getCredential();

  Future<UserEntity> getUserData();
  Future<UserEntity> saveUserData(UserModel data);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences pref;

  AuthLocalDataSourceImpl(this.pref);
  @override
  Future<bool> isLogin() async {
    final userJson = pref.getString('user');
    if (userJson != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<UserEntity> getUserData() async {
    final userJson = await pref.getString('user');
    print("user json $userJson");
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap, token: userMap['token']);
    }
    return const UserEntity(
      userId: '',
      nik: '',
      systemRoleId: 0,
      systemRole: '',
      name: '',
      email: '',
      phone: '',
      departementId: '',
      departement: '',
      siteLocationId: '',
      siteLocation: '',
    );
  }

  @override
  Future<void> credentialSave(String nik, String password) async {
    pref.setString('nik', nik);
    pref.setString('password', password);
    pref.setBool('rememberMe', true);
  }

  @override
  Future<void> removeCredential() async {
    pref.remove('username');
    pref.remove('password');
    pref.setBool('rememberMe', false);
  }

  @override
  Future<CredentialEntity?> getCredential() async {
    String? savedUsername = pref.getString('nik');
    String? savedPassword = pref.getString('password');
    bool? rememberMe = pref.getBool('rememberMe');

    if (savedUsername != null && savedPassword != null) {
      return CredentialEntity(nik: savedUsername, password: savedPassword , rememberMe: rememberMe);
    } else {
      return null;
    }
  }

  @override
  Future<UserEntity> saveUserData(UserModel data) async {
    print("user pre save json $data");

    final userJson = jsonEncode(data.toJson());
    await pref.setString('user', userJson);
    print("user save json $userJson");

    return data;
  }

  Future<void> logout() async {
    await pref.remove('user');
  }
}
