import '../../data/datasources/post_remote_data_source.dart';
import '../entities/post.dart';

/// Abstract class defining the contract for a Post repository.
///
/// This interface is part of the domain layer and defines what operations
/// related to Posts are available to the application's business logic.
/// It abstracts away the details of data retrieval from the data layer.
abstract class PostRepository {
  /// Retrieves a list of [Post] entities.
  ///
  /// This method is the entry point for the application's use cases
  /// to get post data, without needing to know if the data comes from
  /// a remote API, local database, or cache.
  Future<List<Post>> getPosts();
}

/// Concrete implementation of [PostRepository].
///
/// This class bridges the domain layer (PostRepository) with the data layer
/// (PostRemoteDataSource). It fetches data from the remote data source
/// and returns it as domain entities.
class PostRepositoryImpl implements PostRepository {
  /// The remote data source responsible for fetching raw post data.
  final PostRemoteDataSource remoteDataSource;

  /// Creates a [PostRepositoryImpl] with a required [PostRemoteDataSource].
  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Post>> getPosts() async {
    // Delegates the call to the remote data source and returns the result.
    // In a more complex app, this might involve caching logic,
    // error handling, or combining data from multiple sources.
    return await remoteDataSource.getPosts();
  }
}
