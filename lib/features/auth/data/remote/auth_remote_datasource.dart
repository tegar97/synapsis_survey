import 'dart:convert';

import 'package:synapsis_survey/api/urls.dart';
import 'package:synapsis_survey/core/error/excpetion.dart';
import 'package:synapsis_survey/features/auth/data/models/user_model.dart';
import 'package:synapsis_survey/features/auth/domain/entities/user_entitiy.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String nik, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> login(String nik, String password) async {
    Uri url = Uri.parse('${URLs.base}/login');
    final response =
        await client.post(url, body: {'nik': nik, 'password': password});
    
    
    print(response);
    if (response.statusCode == 200) {
      print("oiiii");
      UserModel userData =
          UserModel.fromJson(jsonDecode(response.body)['data']);

      return userData;
    } else if (response.statusCode == 404) {
      Map body = jsonDecode(response.body);

      throw NotFoundException(body['message']);
    } else {
      throw ServerException();
    }
  }
}
