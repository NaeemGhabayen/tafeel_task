
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:tafeel_task/data/datasource/remote/dio/dio_client.dart' show DioClient;
import 'package:tafeel_task/data/repository/user_repo.dart' show UserRepo;
import 'package:tafeel_task/utils/app_constants.dart';

import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'provider/user_provider.dart' show UserProvider;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl, sl(),
      loggingInterceptor: sl(), ));

  sl.registerLazySingleton(
      () => UserRepo(dioClient: sl(), ));

  sl.registerFactory(() => UserProvider(userRepo: sl()));

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}
