# Changelog

All notable changes to the Noun The Wiser app will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Complete Game Flow Implementation**
  - **State-Based Page Switching**: Replaced navigation-based flow with single GamePage widget
    - Dynamic content based on game status and phase
    - Seamless transitions between all game phases
    - Real-time UI updates without navigation conflicts
  - **Full Game Phase Support**:
    - Lobby phase with join code sharing and player management
    - Team assignment with color customization and player switching
    - Manual clue giver selection with host controls
    - Noun selection by clue giver
    - Question selection by team (not clue giver)
    - Clue giving phase with validation
    - Guessing phase with correct/incorrect detection
    - Round end and game end phases (placeholders)
  - **Enhanced Team Management**:
    - Team color picker with reactive UI (Riverpod Consumer)
    - Player team switching during gameplay
    - Manual clue giver assignment via menu
    - Team switching menu accessible from game status banner
  - **Improved Game Logic**:
    - Proper turn progression between teams
    - Correct answer detection and scoring
    - Game phase transitions with validation
    - Current team tracking throughout gameplay

- **UI/UX Improvements**
  - **Keyboard-Friendly Interface**:
    - Scrollable text fields to prevent overflow
    - Keyboard dismissal on tap outside
    - Prevented content resizing issues on mobile
    - Fixed iPhone 11 keyboard coverage problems
  - **Enhanced Game Status Banner**:
    - Menu button for team switching and clue giver assignment
    - Real-time game status and phase display
    - Current team and turn information
  - **Responsive Design**:
    - Flexible text widgets to prevent overflow
    - Proper spacing and layout on all screen sizes
    - Mobile-optimized input fields and buttons

- **Technical Enhancements**
  - **Firebase Serialization Fixes**:
    - Added DateTimeJsonConverter for proper DateTime handling
    - Fixed "Attempting to box non-Dart object" errors
    - Custom JSON converters for complex nested objects
    - Proper toJson/fromJson helpers for turnHistory
  - **State Management Improvements**:
    - TextEditingController lifecycle management
    - Proper disposal of controllers to prevent memory leaks
    - Reactive UI updates with Riverpod Consumer
    - Fixed race conditions in team switching
  - **Error Handling**:
    - Comprehensive error catching and logging
    - Graceful handling of Firebase serialization errors
    - Better user feedback for invalid operations

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

- **Team Assignment Page**: Complete UI for team assignment phase with:
  - Real-time team display with player lists
  - Team color customization with color picker
  - Player team switching functionality
  - Host controls to start the game
  - Visual indicators for current user's team
- **Clue Giver Selection Page**: UI for clue giver assignment phase with:
  - Display of assigned clue givers for each team
  - Manual clue giver reassignment functionality
  - Visual distinction between clue givers and regular players
  - Host controls to continue to game
- **Game Log Widget**: Reusable component for displaying game events with:
  - Different entry types (system, player, team, clue, score, game event)
  - Timestamp formatting and auto-scroll
  - Color-coded entries based on type
  - Player name and team color display
  - Refresh functionality
- **Team Chat Widget**: Real-time team communication component with:
  - Message bubbles with team color theming
  - User avatars and timestamps
  - Auto-scroll to latest messages
  - Input field with send button
  - Error and empty states
- **Navigation Flow**: Automatic navigation between game phases:
  - Lobby → Team Assignment → Clue Giver Selection
  - Real-time status change detection
  - Proper page transitions

### Changed
- **Game Flow Architecture**: Replaced navigation-based flow with state-based UI switching
- **Team Switching**: Moved from floating action button to menu in game status banner
- **Clue Giver Assignment**: Enhanced UI with better visual feedback and controls
- **Game Phase Logic**: Simplified flow by removing separate category selection phase
- Updated game lobby to navigate to team assignment page instead of showing "coming soon"
- Enhanced team assignment page with proper auth provider integration
- Improved UI consistency across all game phases

### Fixed
- **UI Overflow Issues**: Fixed RenderFlex overflow in game page
  - Made text widgets flexible with proper constraints
  - Added scrollable containers where needed
  - Prevented content overflow on smaller screens
- **Keyboard Issues**: Fixed iPhone 11 keyboard coverage problems
  - Made text fields scrollable
  - Added keyboard dismissal on tap outside
  - Prevented content resizing issues
- **Team Switching Logic**: Fixed currentTeamId being null during gameplay
  - Set currentTeamId when noun is selected
  - Proper team progression after incorrect guesses
  - Fixed race conditions in team switching
- **TextEditingController Issues**: Fixed unresponsive text fields on team two's turn
  - Moved controllers to widget state
  - Proper disposal to prevent memory leaks
  - Fixed controller lifecycle management
- **Firebase Serialization**: Fixed "Attempting to box non-Dart object" errors
  - Added custom toJson/fromJson helpers for turnHistory
  - Proper DateTime handling with custom converters
  - Fixed complex nested object serialization
- **Team Serialization Error**: Fixed `Invalid argument: Instance of '_$TeamImpl'` error
  - Added custom JSON converter for Team lists in Game model
  - Updated `_teamListToJson` and `_teamListFromJson` functions
  - Regenerated freezed files with proper Team serialization
- **State Modification Error**: Fixed "trying to modify state in a build method" error
  - Removed automatic navigation from build method
  - Simplified to manual "Start Game" button navigation only
  - Added better error handling and logging
- **Provider State Modification**: Fixed StateNotifierListenerError in team assignment page
  - Moved `watchGame` calls to post-frame callbacks in `initState`
  - Prevented provider state modification during widget lifecycle
  - Applied fix to both team assignment and clue giver selection pages
- **UI Overflow**: Fixed RenderFlex overflow in game lobby
  - Made join code Row more flexible with Flexible widgets
  - Prevented text overflow on smaller screens
- **Build Method Issues**: Removed problematic state modifications during build
  - Eliminated timer-based navigation that caused conflicts
  - Improved reliability of game flow

### Technical
- Fixed auth provider usage in team assignment page
- Added proper imports and navigation between game pages
- Implemented reusable UI components for future game phases
- Enhanced error handling throughout the game flow

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
- ✅ Complete game flow with all phases implemented
- ✅ Team switching and manual clue giver assignment
- ✅ Keyboard-friendly UI with mobile optimization
- ✅ Firebase serialization issues resolved
- 🔄 Game log and team chat functionality (planned)
- 🔄 Online status tracking (planned)

### Next Milestones
1. **Enhanced Features**
   - Game log implementation
   - Team chat functionality
   - Online status tracking
   - Sound effects and animations

2. **Production Readiness**
   - App store preparation
   - Testing and bug fixes
   - Performance monitoring
   - User feedback integration

## [0.3.0] - 2024-01-XX

### Added
- **Game Logic Service**: Core game mechanics implementation
  - Team assignment with automatic balancing
  - Clue giver selection (automatic and manual)
  - Noun and question selection from categories
  - Turn management and progression
  - Badge awarding system
  - Win condition checking
  - Clue validation and scoring
- **Enhanced Game Notifier**: Integration with game logic service
  - Real-time game state updates
  - Firestore transaction support
  - Concurrent update prevention
  - Game phase transitions
- **Team Management**: Advanced team features
  - Team color customization
  - Player team switching
  - Manual clue giver assignment
  - Team balance validation

### Changed
- **Game Model**: Enhanced with new fields and methods
  - Added team colors, clue givers, current turn tracking
  - Added game log, team chat, and scoring fields
  - Improved JSON serialization for nested objects
- **Repository Layer**: Firebase transaction support
  - Atomic updates to prevent race conditions
  - Better error handling and data consistency
  - Real-time synchronization improvements

### Technical
- Fixed serialization issues with User lists in Game model
- Added custom JSON converters for complex data structures
- Regenerated freezed files with proper serialization
- Enhanced error handling throughout the game flow

## [0.2.0] - 2024-01-XX

### Added
- **Firebase Integration**: Complete backend setup
  - Real-time game lobby with Firestore
  - Player join/leave functionality
  - Game status management
  - Real-time updates across devices
- **Game Repository**: Firebase-based game management
  - Create, join, and manage games
  - Real-time game state synchronization
  - Player management and validation
- **Authentication**: Firebase Auth integration
  - Anonymous sign-in with custom names
  - Email/password authentication
  - User profile management
  - Secure user sessions

### Changed
- **Architecture**: Migrated to clean architecture
  - Separated data, domain, and presentation layers
  - Repository pattern for data access
  - Use case pattern for business logic
  - Riverpod for state management
- **Models**: Immutable data models with freezed
  - User model with proper serialization
  - Game model with teams and players
  - Type-safe data structures

### Technical
- Fixed nested User object serialization
- Added proper JSON converters
- Regenerated freezed files
- Enhanced error handling

## [0.1.0] - 2024-01-XX

### Added
- **Project Setup**: Initial Flutter project structure
  - Clean architecture foundation
  - Riverpod state management
  - Firebase configuration
  - Basic UI components
- **Core Features**: Essential game components
  - User authentication system
  - Game creation and joining
  - Basic lobby functionality
  - Team management structure
- **UI Foundation**: Modern, responsive design
  - Material Design 3 theming
  - Consistent spacing and typography
  - Error and loading states
  - Responsive layouts

### Technical
- Initial project setup with Flutter
- Firebase project configuration
- Basic state management with Riverpod
- Clean architecture implementation 