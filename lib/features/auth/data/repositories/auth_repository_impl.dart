import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:synapsis_survey/core/error/excpetion.dart';
import 'package:synapsis_survey/core/error/failures.dart';
import 'package:synapsis_survey/core/platform/network_info_interface.dart';
import 'package:synapsis_survey/features/auth/data/local/auth_local_datasource.dart';
import 'package:synapsis_survey/features/auth/data/remote/auth_remote_datasource.dart';
import 'package:synapsis_survey/features/auth/domain/entities/user_entitiy.dart';
import 'package:synapsis_survey/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(String nik, String password,bool rememberSession) async {
    bool online = await networkInfo.isConnected();
    if (online) {
      try {
        final result = await remoteDataSource.login(nik, password);

        if(rememberSession==true){
        await localDataSource.saveUserData(result);

        }

        return Right(result.toEntity);
      } on TimeoutException {
        return const Left(TimeoutFailure("Timeout. No Response"));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on ServerException {
        return const Left(NotFoundFailure("Server Exception"));
      } catch (e) {
        print(e.toString());
        return const Left(ServerFailure("Somethisng went wrong"));
      }
    } else {
      return const Left(TimeoutFailure("Data is not Present"));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIsLogin() async {
    try {
      final user = await localDataSource.isLogin();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure('Check login failed'));
    }
  }

    @override
  Future<Either<Failure, void>> logout() async {
    try {
      final user = await localDataSource.logout();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure('Check login failed'));
    }
  }
}
