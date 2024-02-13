import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:synapsis_survey/core/error/excpetion.dart';
import 'package:synapsis_survey/core/error/failures.dart';
import 'package:synapsis_survey/core/platform/network_info_interface.dart';
import 'package:synapsis_survey/features/survey/data/models/question_model.dart';
import 'package:synapsis_survey/features/survey/data/remote/survey_remote_datasource.dart';
import 'package:synapsis_survey/features/survey/domain/entities/question_entity.dart';
import 'package:synapsis_survey/features/survey/domain/entities/survey_entity.dart';
import 'package:synapsis_survey/features/survey/domain/repositories/survey_repository.dart';

class SurveyRepositoryImpl extends SurveyRepository {
  final NetworkInfo networkInfo;
  final SurveyRemoteDataSource remoteDataSource;

  SurveyRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SurveyEntity>>> get() async {
    bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDataSource.get();
        // await localDataSource.cachedAll(result);
        return Right(result.map((e) => e.toEntity).toList());
      } on TimeoutException {
        return const Left(TimeoutFailure("Timeout. No Response"));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on ServerException {
        return const Left(NotFoundFailure("Server Exception"));
      } catch (e) {
        print(e.toString());
        return const Left(ServerFailure("Something went wrong"));
      }
    } else {
      return const Left(CachedFailure("No Network"));
    }
  }

  @override
  Future<Either<Failure, QuestionEntity>> getSurveyQuestion(String surveyId) async{
    bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDataSource.getSurveyQuestion(surveyId);
        return Right(result.toEntity());
      } on TimeoutException {
        return const Left(TimeoutFailure("Timeout. No Response"));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on ServerException {
        return const Left(NotFoundFailure("Server Exception"));
      } catch (e) {
        print(e.toString());
        return const Left(ServerFailure("Something went wrong"));
      }
    } else {
      return const Left(CachedFailure("No Network"));
    }
  }
}
