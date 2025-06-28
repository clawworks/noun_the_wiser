# Changelog

All notable changes to the Noun The Wiser app will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Project Foundation & Architecture**
  - Set up clean architecture folder structure with feature-based organization
  - Implemented Riverpod for state management
  - Added Firebase integration for real-time updates and authentication
  - Created immutable models using `freezed` package for type safety
  - Set up theming with custom brand colors and Material 3 design system

- **Authentication System**
  - Implemented anonymous authentication with Firebase Auth
  - Added email/password sign-in functionality
  - Created user profile management with immutable User model
  - Built authentication providers with Riverpod for state management
  - Added mock auth repository for development fallback
  - Implemented proper error handling and loading states

- **Game Management System**
  - Created Game and Team models with proper JSON serialization
  - Implemented Firebase game repository for real-time game operations
  - Added game creation with unique join code generation
  - Built game joining functionality with validation
  - Created real-time game lobby with live player updates
  - Implemented game state management (waiting, in-progress, finished)
  - Added team management and player tracking

- **Game Logic & Core Gameplay**
  - Implemented comprehensive GameLogicService with game mechanics
  - Added team assignment and clue giver selection
  - Built noun and question selection system with categories (Person/Place/Thing)
  - Created turn management and guessing system
  - Implemented badge awarding and win condition checking
  - Added clue validation to enforce game rules
  - Built real-time game phase transitions
  - Created GameTurn tracking for game history

- **Enhanced Team Management**
  - Added team color customization (Green #57CC02, Blue #1CB0F6)
  - Implemented player team switching functionality
  - Added manual clue giver assignment for offline players
  - Built team score and badge tracking system

- **User Interface & Experience**
  - Built responsive home page with game creation and joining options
  - Created clean, modern UI following Material Design principles
  - Implemented proper navigation flow between screens
  - Added loading states and error handling throughout the app
  - Built reusable widgets for consistent UI components
  - Implemented proper form validation and user feedback

- **Development Infrastructure**
  - Set up proper dependency management with pubspec.yaml
  - Configured Firebase for iOS, Android, and Web platforms
  - Added proper error handling and logging
  - Implemented development tools and utilities
  - Created Firebase setup documentation

### Fixed
- **Serialization Issues**
  - Fixed User object serialization in Game model for Firestore compatibility
  - Resolved JSON conversion issues with nested User objects
  - Added custom JSON serialization for User lists
  - Regenerated freezed files to ensure proper code generation

- **Data Consistency & Race Conditions**
  - Implemented Firestore transactions for all game state changes
  - Fixed race conditions when multiple players join/leave simultaneously
  - Added atomic operations for team and player updates
  - Prevented data corruption from concurrent user interactions
  - Added proper error handling for transaction failures

- **Platform Compatibility**
  - Fixed iOS deployment target issues (updated to 13.0)
  - Resolved CocoaPods dependency conflicts
  - Fixed UI overflow issues with responsive design
  - Ensured cross-platform compatibility (iOS, Android, Web)

- **Code Quality**
  - Fixed linter errors and deprecated API usage
  - Removed obsolete generated files
  - Updated imports and dependencies
  - Replaced deprecated color property usage
  - Added proper type safety throughout the codebase

### Technical Details
- **Architecture**: Clean Architecture with feature-based organization
- **State Management**: Riverpod with immutable state
- **Backend**: Firebase Firestore for real-time data
- **Authentication**: Firebase Auth with anonymous and email/password support
- **UI Framework**: Flutter with Material 3 design system
- **Code Generation**: Freezed for immutable models and JSON serialization
- **Platforms**: iOS, Android, and Web support

## [0.1.0] - Initial Development Phase
- Project initialization and foundation setup
- Basic authentication and game management systems
- Core UI components and navigation
- Firebase integration and real-time functionality

---

## Development Notes

### Current Status
- ✅ Authentication system fully functional
- ✅ Game creation and joining working
- ✅ Real-time lobby with player management
- ✅ Cross-platform compatibility established
- ✅ Game logic and core gameplay mechanics implemented
- ✅ Team management and assignment system working
- ✅ Turn management and guessing system ready
- 🔄 Game UI for new phases (team assignment, clue giving, etc.)
- 🔄 Game log and team chat functionality (planned)
- 🔄 Online status tracking (planned)

### Next Milestones
1. **Game UI Implementation**
   - Team assignment screen
   - Clue giver selection interface
   - Noun category selection
   - Question and clue input screens
   - Guessing interface
   - Game log display

2. **Enhanced Features**
   - Team chat functionality
   - Online status tracking
   - Game log implementation
   - Sound effects and animations

3. **Production Readiness**
   - App store preparation
   - Testing and bug fixes
   - Performance monitoring
   - User feedback integration 