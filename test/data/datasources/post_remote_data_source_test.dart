import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:solid/data/datasources/post_remote_data_source.dart';
import 'package:solid/data/models/post_model.dart';

/// A mock class for [Dio] to simulate HTTP responses during testing.
class MockDio extends Mock implements Dio {}

void main() {
  late PostRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  // Set up common dependencies before each test.
  setUp(() {
    mockDio = MockDio();
    dataSource = PostRemoteDataSourceImpl(dio: mockDio);
  });

  group('getPosts', () {
    // Define a list of dummy PostModels for testing.
    final tPostModels = [
      const PostModel(id: 1, title: 'Test Post 1', body: 'This is test post 1'),
      const PostModel(id: 2, title: 'Test Post 2', body: 'This is test post 2'),
    ];

    test(
      'should return List<PostModel> when the response code is 200 (success)',
      () async {
        // Arrange: Mock a successful Dio GET request.
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: json.decode(
                '[{"userId": 1, "id": 1, "title": "Test Post 1", "body": "This is test post 1"}, {"userId": 1, "id": 2, "title": "Test Post 2", "body": "This is test post 2"}]'),
            statusCode: 200,
            requestOptions: RequestOptions(path: 'https://jsonplaceholder.typicode.com/posts'),
          ),
        );
        // Act: Call the getPosts method.
        final result = await dataSource.getPosts();
        // Assert: Verify that Dio's get method was called and the result matches the dummy data.
        expect(result, equals(tPostModels));
      },
    );

    test(
      'should throw an exception when the response code is not 200',
      () async {
        // Arrange: Mock a failed Dio GET request.
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: 'https://jsonplaceholder.typicode.com/posts'),
          ),
        );
        // Act: Define the call to the getPosts method.
        final call = dataSource.getPosts;
        // Assert: Verify that calling getPosts throws an Exception.
        expect(() => call(), throwsA(const TypeMatcher<Exception>()));
      },
    );
  });
}
