import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:solid/data/datasources/post_remote_data_source.dart';
import 'package:solid/domain/repositories/post_repository.dart';
import 'package:solid/presentation/bloc/post_bloc.dart';

/// Global instance of [GetIt] service locator.
///
/// Used to register and retrieve dependencies throughout the application.
final sl = GetIt.instance; // sl is short for Service Locator

/// Initializes the dependency injection container.
///
/// This function registers all the necessary dependencies (BLoCs, repositories,
/// data sources, and core utilities) with GetIt.
Future<void> init() async {
  // --------------------------------------------------------------------------
  // Features - Post
  // --------------------------------------------------------------------------

  // Register PostBloc as a factory, meaning a new instance will be created
  // every time it's requested. It depends on PostRepository.
  sl.registerFactory(() => PostBloc(postRepository: sl()));

  // --------------------------------------------------------------------------
  // Repository
  // --------------------------------------------------------------------------

  // Register PostRepository as a lazy singleton. This means a single instance
  // will be created the first time it's requested and reused thereafter.
  // It depends on PostRemoteDataSource.
  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(remoteDataSource: sl()));

  // --------------------------------------------------------------------------
  // Data sources
  // --------------------------------------------------------------------------

  // Register PostRemoteDataSource as a lazy singleton. It depends on Dio.
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(dio: sl()));

  // --------------------------------------------------------------------------
  // Core
  // --------------------------------------------------------------------------

  // Register Dio as a lazy singleton for making HTTP requests.
  sl.registerLazySingleton(() => Dio());
}
