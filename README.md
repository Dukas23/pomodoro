<div id="top">

<!-- HEADER STYLE: CLASSIC -->
<div align="center">

<img src="readmeai/assets/logos/purple.svg" width="30%" style="position: relative; top: 0; right: 0;" alt="Project Logo"/>

# POMODORO

<em></em>

<!-- BADGES -->
<!-- local repository, no metadata badges. -->

<em>Built with the tools and technologies:</em>

<img src="https://img.shields.io/badge/JSON-000000.svg?style=default&logo=JSON&logoColor=white" alt="JSON">
<img src="https://img.shields.io/badge/Swift-F05138.svg?style=default&logo=Swift&logoColor=white" alt="Swift">
<img src="https://img.shields.io/badge/GNU%20Bash-4EAA25.svg?style=default&logo=GNU-Bash&logoColor=white" alt="GNU%20Bash">
<img src="https://img.shields.io/badge/Gradle-02303A.svg?style=default&logo=Gradle&logoColor=white" alt="Gradle">
<img src="https://img.shields.io/badge/Dart-0175C2.svg?style=default&logo=Dart&logoColor=white" alt="Dart">
<img src="https://img.shields.io/badge/XML-005FAD.svg?style=default&logo=XML&logoColor=white" alt="XML">
<br>
<img src="https://img.shields.io/badge/Flutter-02569B.svg?style=default&logo=Flutter&logoColor=white" alt="Flutter">
<img src="https://img.shields.io/badge/CMake-064F8C.svg?style=default&logo=CMake&logoColor=white" alt="CMake">
<img src="https://img.shields.io/badge/Python-3776AB.svg?style=default&logo=Python&logoColor=white" alt="Python">
<img src="https://img.shields.io/badge/C-A8B9CC.svg?style=default&logo=C&logoColor=black" alt="C">
<img src="https://img.shields.io/badge/Kotlin-7F52FF.svg?style=default&logo=Kotlin&logoColor=white" alt="Kotlin">
<img src="https://img.shields.io/badge/YAML-CB171E.svg?style=default&logo=YAML&logoColor=white" alt="YAML">

</div>
<br>

---

## Overview

Pomodoro is a productivity application built with Flutter. It applies the Pomodoro Technique to break work into focused intervals followed by short breaks, improving concentration and overall efficiency. The app is designed with responsive layouts to support both mobile and desktop experiences.

## Features

- **Pomodoro Timer**: Implements work and break intervals based on the Pomodoro technique.
- **Responsive UI**: Uses adaptive breakpoints to cater for different screen sizes.
- **Theming**: Customizable themes with dedicated theme management.
- **State Management**: Efficient state management using Provider.
- **Structured Navigation**: Maintains clear routing with dedicated navigation files.

---

## Project Structure

```plaintext
.
├── lib/
│   ├── main.dart                # Entry point of the app
│   ├── core/
│   │   └── constants/
│   │       └── adaptative_breakpoints.dart   # Defines breakpoints for responsive design
│   ├── router/
│   │   ├── app_routes.dart       # Route definitions
│   │   └── router.dart           # Navigation logic
│   ├── theme/
│   │   ├── app_theme.dart        # Theme configuration
│   │   └── theme_provider.dart   # Manages theme state
│   ├── utils/
│   │   └── screen_size_util.dart # Utility functions for screen size calculations
│   ├── data/
│   │   ├── models/               # Data model definitions
│   │   └── sources/              # Data source implementations
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── destination_entity.dart   # Domain entity for destinations
│   │   │   └── pomodoro_phase.dart         # Entity representing Pomodoro phases
│   │   └── uses_cases/
│   │       └── pomodoro_timer.dart         # Business logic for the Pomodoro timer
│   └── presentation/
│       ├── managers/             # State managers and controllers
│       ├── pages/
│       │   ├── home/             # Home screen and its widgets
│       │   │   ├── home_screen.dart
│       │   │   └── widgets/
│       │   │       ├── menu_desktop.dart
│       │   │       └── menu_mobile.dart
│       │   └── pomodoro/         # Pomodoro screen and its related widgets
│       │       ├── pomodoro_screen.dart
│       │       └── widgets/
│       │           └── circular_progress_with_contex.dart
│       └── settings/
│           └── settings_screen.dart
```

## Getting Started

### Prerequisites

- Flutter SDK (>= X.X.X)
- Dart SDK
- An IDE such as VS Code or Android Studio

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Dukas23/pomodoro.git
   cd pomodoro
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the Application**
   ```bash
   flutter run
   ```

## Usage

Once the app is running, you can navigate through different screens to start your Pomodoro sessions, adjust settings, and manage your time more effectively. The responsive layout ensures a great user experience on both mobile and desktop platforms.

## Contributing

Contributions are welcome! Please follow these guidelines:

- Fork the repository and create your branch from `main`.
- Make sure your code follows the project's style guidelines.
- Submit a pull request with a detailed explanation of your changes.

For any major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

## Acknowledgments

- Credit `contributors`, `inspiration`, `references`, etc.

<div align="right">

[![][back-to-top]](#top)

</div>


[back-to-top]: https://img.shields.io/badge/-BACK_TO_TOP-151515?style=flat-square


---
