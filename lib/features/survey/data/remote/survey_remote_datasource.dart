import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:synapsis_survey/api/urls.dart';
import 'package:synapsis_survey/core/error/excpetion.dart';
import 'package:synapsis_survey/features/survey/data/models/question_model.dart';
import 'package:synapsis_survey/features/survey/data/models/survey_model.dart';

abstract class SurveyRemoteDataSource {
  Future<List<SurveyModel>> get(String? token);
  Future<QuestionModel> getSurveyQuestion(String surveyId,String? token);
}

class SurveyRemoteDataSourceImpl implements SurveyRemoteDataSource {
  final http.Client client;

  SurveyRemoteDataSourceImpl(this.client);

  @override
  Future<List<SurveyModel>> get(String? token) async {
    Uri url = Uri.parse('${URLs.base}/assessments');
    print("token dari remotedataousce survey $token");
    final response = await client.get(url,
        headers: {'Cookie': 'token=$token'}).timeout(Duration(seconds: 6));

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
  Future<QuestionModel> getSurveyQuestion(String surveyId , String? token) async {
    Uri url = Uri.parse('${URLs.base}/assessments/question/${surveyId}');
    final response = await client.get(url, headers: {
      'Cookie':
          'token=$token'
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
