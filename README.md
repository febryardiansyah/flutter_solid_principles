# Solid Flutter App

This is a Flutter application that demonstrates the implementation of SOLID principles, BLoC pattern, unit testing, dependency injection using GetIt, and CI/CD with GitHub Actions. The app fetches a list of posts from the JSONPlaceholder API and displays them in a list.

## Project Structure

The project is structured into three layers:

-   **Data:** This layer is responsible for handling data from the API.
    -   `datasources`: Contains the remote data source that fetches data from the API using the `dio` package.
    -   `models`: Contains the data models that represent the data from the API.
-   **Domain:** This layer acts as an intermediary between the data layer and the presentation layer.
    -   `entities`: Contains the business objects.
    -   `repositories`: Contains the abstract repository and its implementation.
-   **Presentation:** This layer is responsible for the UI and state management.
    -   `bloc`: Contains the BLoC, events, and states.
    -   `pages`: Contains the UI of the application.

## SOLID Principles

The project adheres to the SOLID principles of object-oriented design:

-   **Single Responsibility Principle (SRP):** Each class has a single responsibility. For example, the `PostRemoteDataSource` is only responsible for fetching posts from the API, and the `PostBloc` is only responsible for managing the state of the posts.
-   **Open/Closed Principle (OCP):** The project is open for extension but closed for modification. For example, you can add a new data source (e.g., a local data source) by implementing the `PostRepository` interface without modifying the existing code.
-   **Liskov Substitution Principle (LSP):** The `PostRepositoryImpl` can be substituted for the `PostRepository` without affecting the behavior of the app.
-   **Interface Segregation Principle (ISP):** The `PostRepository` interface is small and focused on a single responsibility.
-   **Dependency Inversion Principle (DIP):** The `PostBloc` depends on the `PostRepository` abstraction, injected via `get_it`.

## Dependency Injection

The project uses `get_it` for dependency injection. All dependencies are registered in `lib/injection_container.dart` and resolved using the `sl` (service locator) instance.

## CI/CD with GitHub Actions

This project uses GitHub Actions for Continuous Integration (CI). The workflow is defined in `.github/workflows/flutter_ci.yaml`.

The CI pipeline automatically:
- Checks out the code.
- Sets up the Flutter environment.
- Fetches project dependencies.
- Analyzes the code for potential issues (`flutter analyze`).
- Runs all unit tests (`flutter test`).
- Builds the web version of the application (`flutter build web --release`) as a verification step and a placeholder for potential deployment.

This ensures that every push to `main` and every pull request against `main` is automatically validated, maintaining code quality and preventing regressions.

## Getting Started

1.  Clone the repository:
    ```bash
    git clone https://github.com/your-username/solid-flutter-app.git
    ```
2.  Install the dependencies:
    ```bash
    flutter pub get
    ```
3.  Run the app:
    ```bash
    flutter run
    ```

## Running Tests

To run the unit tests, run the following command:

```bash
flutter test
```
