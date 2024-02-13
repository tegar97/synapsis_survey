import 'dart:convert';

import 'package:synapsis_survey/features/auth/data/models/user_model.dart';
import 'package:synapsis_survey/features/auth/domain/entities/user_entitiy.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> isLogin();
  Future<void> logout();

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
    final userJson = pref.getString('user');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return UserEntity(
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
  Future<UserEntity> saveUserData(UserModel data) async {
    final userJson = jsonEncode(data.toJson());
    await pref.setString('user', userJson);
    return data;
  }

  Future<void> logout() async {
    await pref.remove('user');
  }
}
