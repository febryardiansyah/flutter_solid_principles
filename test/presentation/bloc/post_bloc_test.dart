import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solid/domain/entities/post.dart';
import 'package:solid/domain/repositories/post_repository.dart';
import 'package:solid/presentation/bloc/post_bloc.dart';
import 'package:solid/presentation/bloc/post_event.dart';
import 'package:solid/presentation/bloc/post_state.dart';

/// A mock class for [PostRepository] to simulate repository behavior.
class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late MockPostRepository mockPostRepository;
  late PostBloc postBloc;

  // Set up common dependencies before each test.
  setUp(() {
    mockPostRepository = MockPostRepository();
    postBloc = PostBloc(postRepository: mockPostRepository);
  });

  // Define a list of dummy Post entities for testing.
  final tPosts = [
    const Post(id: 1, title: 'title 1', body: 'body 1'),
    const Post(id: 2, title: 'title 2', body: 'body 2'),
  ];

  blocTest<PostBloc, PostState>(
    'emits [PostLoading, PostLoaded] when FetchPosts is added.',
    build: () {
      // Arrange: Mock the PostRepository to return dummy posts when getPosts is called.
      when(() => mockPostRepository.getPosts()).thenAnswer((_) async => tPosts);
      return postBloc;
    },
    act: (bloc) => bloc.add(FetchPosts()), // Act: Add the FetchPosts event.
    expect: () => [
      // Assert: Expect the BLoC to emit PostLoading then PostLoaded with the dummy posts.
      PostLoading(),
      PostLoaded(posts: tPosts),
    ],
  );

  blocTest<PostBloc, PostState>(
    'emits [PostLoading, PostError] when getPosts throws an exception.',
    build: () {
      // Arrange: Mock the PostRepository to throw an exception when getPosts is called.
      when(() => mockPostRepository.getPosts()).thenThrow(Exception('Failed to load posts'));
      return postBloc;
    },
    act: (bloc) => bloc.add(FetchPosts()), // Act: Add the FetchPosts event.
    expect: () => [
      // Assert: Expect the BLoC to emit PostLoading then PostError with the exception message.
      PostLoading(),
      const PostError(message: 'Exception: Failed to load posts'),
    ],
  );
}
