# Flutter Template App

A comprehensive Flutter template application that serves as a foundation for building production-ready mobile applications. This template includes essential features, best practices, and development tools to accelerate your Flutter app development process.

## Features

### Project Setup
- **Project Name & Application ID Customization**: Easy setup script to configure project name and bundle identifiers
- **Flavor Support**: Development and Production environments with separate configurations
- **App Icon Generator**: Automated icon generation for all platforms
- **Native Splash Screen**: Pre-configured splash screen setup

### Architecture & Structure
- **GetX Architecture**: Organized folder structure following best practices
- **GetX State Management**: Pre-configured with GetX for routing, dependency injection, and state management
- **Separated Widgets**: Guidelines for proper widget separation and reuse
- **App Provider**: Base network provider with error handling and connectivity checks

### Services & Utilities
- **Firebase Integration**:
  - Analytics for tracking user behavior
  - Crashlytics for crash reporting
  - Performance monitoring
  - Remote config for feature flags

- **Connectivity Service**: Internet connection monitoring with offline mode support
- **Force Update**: App version checking and forced update functionality
- **Analytics Service**: Tracking user events and screen views
- **Screen Utils**: Responsive UI utilities for different screen sizes
- **Secure Storage**: Encrypted local storage for sensitive data

### Development Tools
- **Linting**: Pre-configured lint rules for code quality
- **Git Integration**: Proper .gitignore setup
- **Asset Generation**: Automated asset generation for images and fonts
- **Cursor Rules**: Custom rules for maintaining code quality and consistency

## Project Guidelines

### Code Organization
- **Localization**: Separate files for text constants
- **API Parameters**: Structured API parameter management
- **Route Parameters**: Organized route parameter handling
- **Test Keys**: Consistent test key management for widget testing

### Styling Guidelines
- **Screen Utils**: Use `.h`, `.w`, `.sp`, and `.r` extensions for responsive UI
- **Color Management**: Centralized color definitions
- **Padding & Margins**: Consistent spacing through predefined values

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio / VS Code with Flutter plugins
- Git

### Setup Instructions

1. Clone the repository:
```bash
git clone https://github.com/yourusername/flutter_template_app.git
```

2. Run the setup script to configure your project:
```bash
# On Windows
./setup_project.ps1

# Follow the prompts to set your project name and application ID
```

3. Enable Firebase (Optional):
   - Create a Firebase project
   - Add Android and iOS apps to your Firebase project
   - Download the configuration files:
     - `google-services.json` for Android
     - `GoogleService-Info.plist` for iOS
   - Place them in the appropriate directories
   - Uncomment Firebase-related code using the Cursor rule:
     ```
     @uncomment_fire_base.mdc
     ```

4. Run the app:
```bash
# Development environment
flutter run --flavor dev -t lib/main_dev.dart

# Production environment
flutter run --flavor prod -t lib/main_prod.dart
```

## Project Structure

```
lib/
├── app/
│   ├── core/
│   │   ├── values/      # Constants, themes, and styles
│   │   ├── utliz/       # Utility functions and helpers
│   │   ├── helpers/     # Helper classes
│   │   └── exceptions/  # Custom exceptions
│   ├── data/
│   │   ├── models/      # Data models
│   │   ├── providers/   # API providers
│   │   └── services/    # Business logic services
│   ├── modules/         # Feature modules
│   │   └── [feature]/
│   │       ├── bindings/
│   │       ├── controllers/
│   │       ├── views/
│   │       └── widgets/
│   └── routes/          # App routes
├── gen/                 # Generated files
├── flavors.dart         # Environment configuration
├── main_common.dart     # Common initialization code
├── main_dev.dart        # Development entry point
├── main_prod.dart       # Production entry point
└── my_app.dart          # App configuration
```

## Cursor Rules

This template includes several Cursor rules to maintain code quality:

- `set_project_setting.mdc`: Updates project name and application ID
- `uncomment_fire_base.mdc`: Enables Firebase integration
- `seperate_widgets.mdc`: Enforces widget separation
- `guidelines.mdc`: Code quality guidelines
- `screen_utilz_color.mdc`: UI consistency guidelines

## License

This project is licensed under the MIT License - see the LICENSE file for details.
