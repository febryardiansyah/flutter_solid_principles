import 'package:flutter/material.dart';
import 'presentation/pages/home_page.dart';
import 'injection_container.dart' as di; // di as in dependency injection

/// The entry point of the Flutter application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize GetIt
  runApp(const MyApp());
}

/// The root widget of the application.
///
/// This widget sets up the basic material app structure and defines
/// the application's theme and home page.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SOLID BLoC',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Defines the primary color for the app
      ),
      home: const HomePage(), // Sets the HomePage as the initial screen
    );
  }
}