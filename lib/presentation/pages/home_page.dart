import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid/injection_container.dart'; // Import the service locator
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import '../bloc/post_state.dart';

/// The home page of the application, responsible for displaying a list of posts.
///
/// This widget uses [BlocProvider] to create and provide a [PostBloc]
/// to its descendants, and [BlocBuilder] to react to [PostState] changes
/// and update the UI accordingly.
class HomePage extends StatelessWidget {
  /// Creates a [HomePage].
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocProvider(
        // Create and provide the PostBloc to the widget tree using GetIt.
        // GetIt resolves the PostBloc and its dependencies automatically.
        create: (context) => sl<PostBloc>()..add(FetchPosts()), // Dispatch the FetchPosts event immediately
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              // Display a loading indicator when posts are being fetched.
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostLoaded) {
              // Display the list of posts when they are successfully loaded.
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              );
            } else if (state is PostError) {
              // Display an error message if fetching posts failed.
              return Center(
                child: Text(state.message),
              );
            }
            // Default state, typically shown before any event is dispatched.
            return const Center(
              child: Text('Press the button to fetch posts'),
            );
          },
        ),
      ),
    );
  }
}
