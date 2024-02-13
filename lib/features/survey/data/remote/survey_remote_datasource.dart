import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:synapsis_survey/api/urls.dart';
import 'package:synapsis_survey/core/error/excpetion.dart';
import 'package:synapsis_survey/features/survey/data/models/question_model.dart';
import 'package:synapsis_survey/features/survey/data/models/survey_model.dart';

abstract class SurveyRemoteDataSource {
  Future<List<SurveyModel>> get();
  Future<QuestionModel> getSurveyQuestion(String surveyId);
}

class SurveyRemoteDataSourceImpl implements SurveyRemoteDataSource {
  final http.Client client;

  SurveyRemoteDataSourceImpl(this.client);

  @override
  Future<List<SurveyModel>> get() async {
    Uri url = Uri.parse('${URLs.base}/assessments');
    final response = await client.get(url, headers: {
      'Cookie':
          'refresh_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlX2lkIjoiIiwicGVybWlzc2lvbnMiOm51bGwsImV4cCI6MTcxMDM5MTU0NiwiaXNzIjoiU1lOMTAifQ.myCYuTc4xKM9jIogNnldAzEpEy3nzBZJuwThLaPUKh0; token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlX2lkIjoiNCIsInBlcm1pc3Npb25zIjpbMTMwLDEzMywxMzUsMTM4LDE0MiwxNTQsMSwyLDMsNCw1LDYsOSwxMSwxMiwxMywxNywxMCw4XSwiZXhwIjoxNzA3ODg1OTQ2LCJpc3MiOiJTWU4xMCJ9.ZxBaVV8byNr-caARKIMkc01sEfmrdHFgRYlmfsiQOJk'
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

  @override
  Future<QuestionModel> getSurveyQuestion(String surveyId) async {
    Uri url = Uri.parse('${URLs.base}/assessments/question/${surveyId}');
    final response = await client.get(url, headers: {
      'Cookie':
          'refresh_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlX2lkIjoiIiwicGVybWlzc2lvbnMiOm51bGwsImV4cCI6MTcxMDM5MTU0NiwiaXNzIjoiU1lOMTAifQ.myCYuTc4xKM9jIogNnldAzEpEy3nzBZJuwThLaPUKh0; token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlX2lkIjoiNCIsInBlcm1pc3Npb25zIjpbMTMwLDEzMywxMzUsMTM4LDE0MiwxNTQsMSwyLDMsNCw1LDYsOSwxMSwxMiwxMywxNywxMCw4XSwiZXhwIjoxNzA3ODg1OTQ2LCJpc3MiOiJTWU4xMCJ9.ZxBaVV8byNr-caARKIMkc01sEfmrdHFgRYlmfsiQOJk'
    }).timeout(Duration(seconds: 6));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      QuestionModel data = QuestionModel.fromJson(responseData['data']);
      return data;
    } else if (response.statusCode == 404) {
      Map body = jsonDecode(response.body);

      throw NotFoundException(body['message']);
    } else {
      throw ServerException();
    }
  }
}
