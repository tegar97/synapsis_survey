import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:synapsis_survey/api/urls.dart';
import 'package:synapsis_survey/core/error/excpetion.dart';
import 'package:synapsis_survey/features/survey/data/models/survey_model.dart';

abstract class SurveyRemoteDataSource {
  Future<List<SurveyModel>> get();
}

class SurveyRemoteDataSourceImpl implements SurveyRemoteDataSource {
  final http.Client client;

  SurveyRemoteDataSourceImpl(this.client);

  @override
  Future<List<SurveyModel>> get() async {
    Uri url = Uri.parse('${URLs.base}/assessments');
    final response = await client.get(url , headers: {
      'Cookie' : 'refresh_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlX2lkIjoiIiwicGVybWlzc2lvbnMiOm51bGwsImV4cCI6MTcxMDM0NjIyMiwiaXNzIjoiU1lOMTAifQ.EUwhtsCmqkj6wUf4Ah5JzyM0NA3khTW7-fAiJQDkJT4; token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlX2lkIjoiNCIsInBlcm1pc3Npb25zIjpbMTMwLDEzMywxMzUsMTM4LDE0MiwxNTQsMSwyLDMsNCw1LDYsOSwxMSwxMiwxMywxNywxMCw4XSwiZXhwIjoxNzA3ODQwNjIyLCJpc3MiOiJTWU4xMCJ9.F_Q-Eyp5I2zU2kxBDPSMdyZYoZn26dJ9A0t9A7DS0ek'
    }).timeout(Duration(seconds: 6));

    if (response.statusCode == 200) {
      List list = jsonDecode(response.body)['data'];
      print(list);
      return list.map((e) => SurveyModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      Map body = jsonDecode(response.body);

      throw NotFoundException(body['message']);
    } else {
      throw ServerException();
    }
  }
}
