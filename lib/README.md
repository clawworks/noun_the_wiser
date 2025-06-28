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
│   │   │   └── user.dart  # User entity
│   │   └── presentation/  # UI layer (pages, widgets, providers)
│   ├── game/              # Game feature
│   │   ├── data/          # Data layer
│   │   ├── domain/        # Business logic
│   │   │   └── game.dart  # Game entity
│   │   └── presentation/  # UI layer
│   └── home/              # Home feature
│       ├── data/          # Data layer
│       ├── domain/        # Business logic
│       └── presentation/  # UI layer
├── shared/                # Shared components and utilities
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
  - **Entities**: Core business objects (User, Game, Team, etc.)
  - **Use Cases**: Business logic and rules
  - **Repositories**: Abstract interfaces for data access
- **Presentation Layer**: Manages UI, state management, and user interactions

### 3. Domain-Driven Design
- **User Entity**: Lives in `auth/domain/` - represents authenticated users
- **Game Entity**: Lives in `game/domain/` - represents game state and logic
- Each feature owns its domain entities and business rules

### 4. Shared Components
- Common widgets, services, and utilities are placed in the `shared` folder
- These components can be used across multiple features
- No domain-specific logic in shared components

### 5. Core Utilities
- App-wide constants, error handling, and utility functions
- Theme and styling constants
- Network and platform-specific code

## Key Files

### Constants
- `app_constants.dart`: Game rules, limits, and app configuration
- `theme_constants.dart`: Colors, text styles, and theme configuration

### Domain Entities
- `auth/domain/user.dart`: User/player data model
- `game/domain/game.dart`: Game state, teams, and game logic models

### Widgets
- `loading_widget.dart`: Reusable loading indicator
- `error_widget.dart`: Reusable error display widget

### Utilities
- `join_code_generator.dart`: Generates and validates game join codes
- `failures.dart`: Error handling and failure types

## Clean Architecture Benefits

1. **Separation of Concerns**: Each layer has a specific responsibility
2. **Testability**: Business logic is isolated and easily testable
3. **Maintainability**: Changes in one layer don't affect others
4. **Scalability**: Easy to add new features without breaking existing code
5. **Domain Focus**: Business rules are centralized in domain layer

## Next Steps

1. Add Riverpod dependencies and set up state management
2. Implement authentication feature with proper domain logic
3. Create game logic and real-time updates
4. Build UI components for each feature
5. Add theming and dark mode support
6. Implement real-time multiplayer functionality 