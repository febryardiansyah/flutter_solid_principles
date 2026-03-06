import 'package:dio/dio.dart';
import '../models/post_model.dart';

/// Abstract class defining the contract for a remote data source for posts.
///
/// This adheres to the Dependency Inversion Principle, allowing the
/// repository to depend on an abstraction rather than a concrete implementation.
abstract class PostRemoteDataSource {
  /// Fetches a list of [PostModel] from a remote API.
  ///
  /// Throws an [Exception] if the API call fails.
  Future<List<PostModel>> getPosts();
}

/// Concrete implementation of [PostRemoteDataSource] using the Dio HTTP client.
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  /// The Dio client used for making HTTP requests.
  final Dio dio;

  /// Creates a [PostRemoteDataSourceImpl] with a required [Dio] instance.
  PostRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      final List<dynamic> data = response.data;
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load posts');
    }
  }
}
