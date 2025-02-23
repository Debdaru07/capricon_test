# Capricorn_Test

This project is a Flutter application designed for Capricorn Company's Test, Stock-Broking Application. 
It leverages Riverpod for state management, REST APIs for data fetching, etc. to provide a robust and scalable solution.

## Local Setup

To run this project locally, follow these steps:

1.  **Install Flutter**:
    * Ensure Flutter is installed on your machine. Download and install it from the [official Flutter website](https://flutter.dev/docs/get-started/install).
    * Run `flutter doctor` in your terminal to verify the installation and resolve any issues.

2.  **Clone the Repository**:
    * Clone this repository to your local machine:
        ```bash
        git clone https://github.com/Debdaru07/capricon_test.git
        ```

3.  **Install Dependencies**:
    * Navigate to the project directory:
        ```bash
        cd capricorn_test
        ```
    * Install the required dependencies:
        ```bash
        flutter pub get
        ```

4.  **Run the App**:
    * Connect a physical device or start an emulator/simulator.
    * Run the app:
        ```bash
        flutter run
        ```

## Folder Structure

The project follows a modular and organized structure to separate concerns and improve code maintainability. Here's a breakdown of the key directories and files:

* `android/`: Contains Android-specific configuration files for the app.
* `ios/`: Contains iOS-specific configuration files for the app.
* `assets/`: Stores static assets like images, fonts, or JSON files used in the app.
* `build/`: Generated files from the build process (typically managed by Flutter).
* `lib/`: The main source code directory for Dart files, organized as follows:
    * `core/`: Contains core utilities and shared logic:
        * `api_client.dart`: Handles API calls and network requests.
        * `constants.dart`: Defines constants used across the app (e.g., API endpoints, strings).
    * `model/`: Data models for the app:
        * `auth_model.dart`: Represents authentication-related data.
        * `login_auth_model.dart`: Specific model for login authentication.
        * `stock_id_model.dart`: Model for stock IDs.
        * `stock_model.dart`: General stock data model.
        * `stock_search_model.dart`: Model for stock search results.
    * `providers/`: State management using providers (likely Riverpod or Provider package):
        * `login_provider.dart`: Manages login state and logic.
        * `password_toggler_provider.dart`: Handles password visibility toggling.
        * `stock_details_provider.dart`: Manages stock details state.
        * `stock_holdings_provider.dart`: Manages stock holdings or portfolio state.
        * `stock_search_provider.dart`: Manages stock search functionality.
    * `view/`: UI-related files (screens and widgets):
        * `stock_holdings/`: Contains widgets or screens related to stock holdings.
        * `home_screen.dart`: The main home screen of the app.
        * `login.dart`: The login screen for user authentication.
        * `stock_details.dart`: Screen displaying stock details.
        * `main.dart`: The entry point of the application, setting up the app structure and routing.
* `.dart_tool/`, `.idea/`, `.vscode/`: IDE-specific configuration files for Dart, IntelliJ/Android Studio, and Visual Studio Code, respectively.

## Screens

Based on the folder structure, the app includes the following key screens:

* **Home Screen (`home_screen.dart`):** The primary dashboard or landing screen after login, likely displaying stock summaries or navigation options.
* **Login Screen (`login.dart`):** Handles user authentication, allowing users to log in to access stock features.
* **Stock Details Screen (`stock_details.dart`):** Displays detailed information about a specific stock, such as price, volume, and other metrics.
* **Stock Holdings Screen (`stock_holdings/`):** Manages and displays the user's stock portfolio or holdings.

## Dependencies

The project likely uses Flutter packages for functionality like state management, HTTP requests, and UI components. To view and manage dependencies, check the `pubspec.yaml` file in the root directory. Common dependencies might include:

* `flutter_riverpod` or `provider` for state management.
* `dio` for API calls.
* `cupertino_icons` for Apple Icons Library 
* `google_fonts` for Google Fonts Library
* `url_launcher` for Launching a URL in a browser

Run `flutter pub get` to install these dependencies after cloning the repository.

## Contributing

We welcome contributions! If you'd like to contribute to `Capricorn_Test`, please:

1.  Fork the repository.
2.  Create a new branch for your feature or bug fix.
3.  Submit a pull request with a clear description of your changes.