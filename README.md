# Refuelety - Nearby Fuel Prices

Refuelety is a mobile app that displays nearby fuel stations, including their current fuel prices and additional information such as distance, brand, and opening hours. The app supports both Android and iOS.

## Features

- **Fuel Station Overview:** Displays a list of fuel stations near you.
- **Price Comparison:** Compare current prices for Diesel, E5, and E10.
- **Filters:** Filter stations by price, brand, and distance.
- **Opening Hours:** See which stations are currently open or closed.


## Screenshots
**Coming soon...**


## Installation

### Requirements

- **Flutter SDK:** Version 3.22.2
- **Dart:** Version 3.4.3
- **Development Environment:** Android Studio or Xcode for running on an emulator or physical device

### Recommendation
We recommend to use [fvm](https://fvm.app/) tool to manage your flutter versions.

### Install Dependencies

Run the following command in the terminal to install all required dependencies:
```bash
flutter pub get
```
### Run the App

Use the following command to run the app on an emulator or physical device:
```bash
flutter run
```

## Support

This app supports both Android and iOS. Make sure you have the correct emulators or physical devices set up to test the app on both platforms.

### Android
- **Minimum SDK Version:** 21
- **Target SDK Version:** 34

### IOS
- **Minimum Deployment Target:** iOS 11.0

## Folder Structure

The basic folder structure of this app is as follows:
```plaintext 
lib/
├── main.dart          # Entry point of the app
├── api/               # Data models (e.g., FuelStation)
├── components/        # Various feature based screens and widgets of the app
├── core/              # Necessary services to run the app
└── misc/              # Helper classes, widgets and more
```

## API Integration
The app uses an external API to fetch fuel stations and their prices. More information on the API and how it is integrated can be found in services/api_service.dart.

## Contributions
Contributions are welcome! If you find a bug or want to propose a new feature, please open an issue or submit a pull request.

### Creating new models
Since we are using freezed package to build our models. Please don't forget generate the auto generated files.
```bash
dart run build_runner build --delete-conflicting-outputs
```

## License
This app is licensed under the MIT License. For more details, see the LICENSE file.

## Kontakt
For questions or issues, feel free to reach out to [buggxs](https://github.com/buggxs), [killerpanda03](https://github.com/killerpanda03), [Astanto96](https://github.com/Astanto96) on GitHub.

### Überblick
- **Features:** A brief description of the app's features.
- **Screenshots:** A section to include screenshots of the app's interface.
- **Installation:** Instructions for setting up the dependencies and running the app.
- **Support:** Information on platform support for Android and iOS.
- **Folder Structure:** Overview of the main directories in the project.
- **API Integration:** A note on how the app connects to an external API.
- **Contributions:** Guidelines for contributing to the project.
- **License:** Reference to the license file.
- **Contact:** Contact information for the repository owner.