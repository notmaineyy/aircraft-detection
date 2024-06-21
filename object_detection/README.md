# Aircraft Detector and Classifier Mobile App

## Overview

This is the aircraft detector and classifier mobile app developed using Flutter. It is designed to be cross-platform, supporting Android, iOS, web, and desktop (Windows, macOS, and Linux).

## Project Structure

The project is organised as follows:

```bash
flutter_project/
├── android/ # Android-specific code and configuration
├── assets/ # YOLOv8 model
├── ios/ # iOS-specific code and configuration
├── lib/ # Main source code of the Flutter application
├── linux/ # Linux-specific code and configuration
├── macos/ # macOS-specific code and configuration
├── test/ # Unit and widget tests
├── web/ # Web-specific code and configuration
├── windows/ # Windows-specific code and configuration
│
├── .gitignore # Git ignore file
├── .metadata # Metadata for the project
├── README.md # Project readme file
├── analysis_options.yaml # Analysis options for Dart static analysis
├── pubspec.lock # Lockfile for package dependencies
├── pubspec.yaml # Project configuration and dependencies
```

## Getting Started

To get started with this project, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/notmaineyy/aircraft-detection.git
   cd aircraft-detection/object-detection

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the app:**
   ```bash
   flutter run

