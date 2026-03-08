import '../../domain/entities/post.dart';

/// Represents a Post data model, extending the domain [Post] entity.
///
/// This class is responsible for handling data serialization and deserialization
/// from/to JSON, specifically for the data layer.
class PostModel extends Post {
  /// Creates a [PostModel] with the given [id], [title], and [body].
  const PostModel({
    required super.id,
    required super.title,
    required super.body,
  });

  /// Creates a [PostModel] from a JSON map.
  ///
  /// This factory method is used to parse the JSON response from the API
  /// into a [PostModel] object.
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(id: json['id'], title: json['title'], body: json['body']);
  }

  /// Converts this [PostModel] into a JSON map.
  ///
  /// This method is useful for sending data to an API, though not directly
  /// used in this read-only example.
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body};
  }
}
