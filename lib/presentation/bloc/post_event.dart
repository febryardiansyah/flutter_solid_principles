import 'package:equatable/equatable.dart';

/// Base class for all events related to Post functionality.
///
/// Events are inputs to the BLoC, typically triggered by user interactions
/// or other parts of the application, to request a state change.
abstract class PostEvent extends Equatable {
  /// Constructor for [PostEvent].
  const PostEvent();

  @override
  List<Object> get props => [];
}

/// Event to request fetching of posts.
///
/// When this event is added to the [PostBloc], it triggers the BLoC
/// to retrieve posts from the repository.
class FetchPosts extends PostEvent {}
