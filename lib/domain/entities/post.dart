import 'package:equatable/equatable.dart';

/// Represents a Post entity in the domain layer.
///
/// This class is an immutable data holder for post information,
/// ensuring consistency and simplifying equality checks with `Equatable`.
class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  /// Creates a [Post] with the given [id], [title], and [body].
  const Post({required this.id, required this.title, required this.body});

  @override
  List<Object?> get props => [id, title, body];
}
