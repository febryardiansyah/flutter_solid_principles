import 'package:equatable/equatable.dart';
import '../../domain/entities/post.dart';

/// Base class for all states related to Post functionality.
///
/// States represent the different conditions or data that the UI can display.
abstract class PostState extends Equatable {
  /// Constructor for [PostState].
  const PostState();

  @override
  List<Object> get props => [];
}

/// Initial state of the Post BLoC.
///
/// Indicates that no operation has been performed yet.
class PostInitial extends PostState {}

/// Loading state of the Post BLoC.
///
/// Indicates that posts are currently being fetched.
class PostLoading extends PostState {}

/// Loaded state of the Post BLoC.
///
/// Contains the list of successfully fetched [Post] objects.
class PostLoaded extends PostState {
  /// The list of posts.
  final List<Post> posts;

  /// Creates a [PostLoaded] state with the given list of [posts].
  const PostLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

/// Error state of the Post BLoC.
///
/// Contains an error message if fetching posts failed.
class PostError extends PostState {
  /// The error message.
  final String message;

  /// Creates a [PostError] state with the given [message].
  const PostError({required this.message});

  @override
  List<Object> get props => [message];
}
