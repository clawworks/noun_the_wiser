# Noun The Wiser - Flutter App Structure

This document outlines the folder structure and organization of the Noun The Wiser Flutter application.

## Folder Structure

```
lib/
├── core/                    # Core functionality and utilities
│   ├── constants/          # App-wide constants
│   │   ├── app_constants.dart
│   │   └── theme_constants.dart
│   ├── errors/             # Error handling
│   │   └── failures.dart
│   ├── network/            # Network-related code (to be implemented)
│   └── utils/              # Utility functions
│       └── join_code_generator.dart
├── features/               # Feature-based modules
│   ├── auth/              # Authentication feature
│   │   ├── data/          # Data layer (repositories, data sources)
│   │   ├── domain/        # Business logic (entities, use cases)
│   │   └── presentation/  # UI layer (pages, widgets, providers)
│   ├── game/              # Game feature
│   │   ├── data/          # Data layer
│   │   ├── domain/        # Business logic
│   │   └── presentation/  # UI layer
│   └── home/              # Home feature
│       ├── data/          # Data layer
│       ├── domain/        # Business logic
│       └── presentation/  # UI layer
├── shared/                # Shared components and utilities
│   ├── models/            # Shared data models
│   │   ├── user.dart
│   │   └── game.dart
│   ├── providers/         # Shared Riverpod providers
│   ├── services/          # Shared services
│   └── widgets/           # Reusable widgets
│       ├── loading_widget.dart
│       └── error_widget.dart
└── main.dart              # App entry point
```

## Architecture Principles

### 1. Feature-First Organization
- Each feature is self-contained with its own data, domain, and presentation layers
- Features can be developed and tested independently
- Clear separation of concerns

### 2. Clean Architecture
- **Data Layer**: Handles data sources, repositories, and external APIs
- **Domain Layer**: Contains business logic, entities, and use cases
- **Presentation Layer**: Manages UI, state management, and user interactions

### 3. Shared Components
- Common models, widgets, and utilities are placed in the `shared` folder
- These components can be used across multiple features

### 4. Core Utilities
- App-wide constants, error handling, and utility functions
- Theme and styling constants
- Network and platform-specific code

## Key Files

### Constants
- `app_constants.dart`: Game rules, limits, and app configuration
- `theme_constants.dart`: Colors, text styles, and theme configuration

### Models
- `user.dart`: User/player data model
- `game.dart`: Game state, teams, and game logic models

### Widgets
- `loading_widget.dart`: Reusable loading indicator
- `error_widget.dart`: Reusable error display widget

### Utilities
- `join_code_generator.dart`: Generates and validates game join codes
- `failures.dart`: Error handling and failure types

## Next Steps

1. Add Riverpod dependencies and set up state management
2. Implement authentication feature
3. Create game logic and real-time updates
4. Build UI components for each feature
5. Add theming and dark mode support
6. Implement real-time multiplayer functionality 