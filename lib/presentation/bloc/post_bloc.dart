import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

/// BLoC (Business Logic Component) for managing Post-related states.
///
/// This BLoC handles [PostEvent]s and emits [PostState]s,
/// orchestrating the data flow between the UI and the domain layer
/// (via [PostRepository]).
class PostBloc extends Bloc<PostEvent, PostState> {
  /// The repository responsible for fetching post data.
  final PostRepository postRepository;

  /// Creates a [PostBloc] with a required [PostRepository].
  ///
  /// Initializes the BLoC with [PostInitial] state and registers
  /// event handlers.
  PostBloc({required this.postRepository}) : super(PostInitial()) {
    /// Event handler for [FetchPosts].
    ///
    /// When a [FetchPosts] event is added, the BLoC first emits [PostLoading],
    /// then attempts to fetch posts from the [postRepository].
    /// If successful, it emits [PostLoaded] with the fetched posts.
    /// If an error occurs, it emits [PostError] with an error message.
    on<FetchPosts>((event, emit) async {
      emit(PostLoading()); // Indicate that posts are being loaded
      try {
        final posts = await postRepository.getPosts(); // Fetch posts from repository
        emit(PostLoaded(posts: posts)); // Emit success state with posts
      } catch (e) {
        emit(PostError(message: e.toString())); // Emit error state if fetching fails
      }
    });
  }
}
