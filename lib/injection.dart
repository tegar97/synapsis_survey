import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_survey/core/platform/network_info_impl.dart';
import 'package:synapsis_survey/core/platform/network_info_interface.dart';
import 'package:synapsis_survey/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:synapsis_survey/features/auth/data/local/auth_local_datasource.dart';
import 'package:synapsis_survey/features/auth/data/remote/auth_remote_datasource.dart';
import 'package:synapsis_survey/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:synapsis_survey/features/auth/domain/repositories/auth_repository.dart';
import 'package:synapsis_survey/features/auth/domain/usecases/check_login_usecase.dart';
import 'package:synapsis_survey/features/auth/domain/usecases/login_usecase.dart';
import 'package:synapsis_survey/features/auth/domain/usecases/logout_usecase.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // bloc

  locator.registerFactory(() => AuthBloc(locator(), locator(),locator()));

  // usecase

  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => CheckLoginUseCase(locator()));
  locator.registerLazySingleton(() => LogoutUseCase(locator()));

  
  //DATASOURCE 
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(locator()));

  //repository

  locator.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: locator(), remoteDataSource: locator(),localDataSource: locator()));

  // platform

  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));




  // external
    final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => Connectivity());
  locator.registerLazySingleton(() => http.Client());
}
