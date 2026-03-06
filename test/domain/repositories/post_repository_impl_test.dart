import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solid/data/datasources/post_remote_data_source.dart';
import 'package:solid/data/models/post_model.dart';
import 'package:solid/domain/entities/post.dart';
import 'package:solid/domain/repositories/post_repository.dart';

/// A mock class for [PostRemoteDataSource] to simulate data source behavior.
class MockPostRemoteDataSource extends Mock implements PostRemoteDataSource {}

void main() {
  late PostRepositoryImpl repository;
  late MockPostRemoteDataSource mockRemoteDataSource;

  // Set up common dependencies before each test.
  setUp(() {
    mockRemoteDataSource = MockPostRemoteDataSource();
    repository = PostRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('getPosts', () {
    // Define a list of dummy PostModels for testing.
    final tPostModels = [
      const PostModel(id: 1, title: 'Test Post 1', body: 'This is test post 1'),
      const PostModel(id: 2, title: 'Test Post 2', body: 'This is test post 2'),
    ];

    // Cast the PostModels to Post entities for comparison with the repository's output.
    final List<Post> tPosts = tPostModels;

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // Arrange: Mock the remote data source to return dummy PostModels.
        when(() => mockRemoteDataSource.getPosts())
            .thenAnswer((_) async => tPostModels);
        // Act: Call the getPosts method on the repository.
        final result = await repository.getPosts();
        // Assert: Verify that the remote data source's getPosts method was called
        // and that the repository returns the expected list of Post entities.
        verify(() => mockRemoteDataSource.getPosts());
        expect(result, equals(tPosts));
      },
    );

    test(
      'should throw an exception when the call to remote data source is unsuccessful',
      () async {
        // Arrange: Mock the remote data source to throw an exception.
        when(() => mockRemoteDataSource.getPosts())
            .thenThrow(Exception('Failed to load posts'));
        // Act: Define the call to the getPosts method on the repository.
        final call = repository.getPosts;
        // Assert: Verify that calling getPosts on the repository throws an Exception.
        expect(() => call(), throwsA(const TypeMatcher<Exception>()));
      },
    );
  });
}
