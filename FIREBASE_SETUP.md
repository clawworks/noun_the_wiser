# Firebase Setup Guide for Noun The Wiser

This guide will help you set up Firebase for the Noun The Wiser app.

## Prerequisites

1. Install the FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

2. Make sure you have Firebase CLI installed:
```bash
npm install -g firebase-tools
```

## Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter a project name (e.g., "noun-the-wiser")
4. Choose whether to enable Google Analytics (recommended)
5. Click "Create project"

## Step 2: Configure Firebase for Your App

1. In the Firebase Console, click on your project
2. Click the gear icon next to "Project Overview" and select "Project settings"
3. In the "Your apps" section, click "Add app"
4. Choose the platforms you want to support:
   - Web (for web deployment)
   - iOS (for iPhone/iPad)
   - Android (for Android devices)
   - macOS (for Mac desktop)

### For Web:
1. Register app with a nickname (e.g., "noun-the-wiser-web")
2. Copy the configuration object
3. Update `lib/firebase_options.dart` with the web configuration

### For iOS:
1. Register app with your bundle ID (e.g., "com.example.nounTheWiser")
2. Download the `GoogleService-Info.plist` file
3. Add it to your iOS project in Xcode
4. Update `lib/firebase_options.dart` with the iOS configuration

### For Android:
1. Register app with your package name (e.g., "com.example.noun_the_wiser")
2. Download the `google-services.json` file
3. Place it in `android/app/`
4. Update `lib/firebase_options.dart` with the Android configuration

### For macOS:
1. Register app with your bundle ID (e.g., "com.example.nounTheWiser")
2. Download the `GoogleService-Info.plist` file
3. Add it to your macOS project in Xcode
4. Update `lib/firebase_options.dart` with the macOS configuration

## Step 3: Enable Authentication

1. In Firebase Console, go to "Authentication"
2. Click "Get started"
3. Go to the "Sign-in method" tab
4. Enable the authentication methods you want:
   - **Anonymous** (for quick sign-in)
   - **Email/Password** (for traditional accounts)
5. Click "Save"

## Step 4: Update Firebase Options

Replace the placeholder values in `lib/firebase_options.dart` with your actual Firebase configuration:

```dart
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'your-actual-web-api-key',
  appId: 'your-actual-web-app-id',
  messagingSenderId: 'your-actual-sender-id',
  projectId: 'your-actual-project-id',
  authDomain: 'your-actual-project-id.firebaseapp.com',
  storageBucket: 'your-actual-project-id.appspot.com',
);
```

## Step 5: Test the Setup

1. Run the app:
```bash
flutter run
```

2. Try signing in anonymously - it should work with Firebase now
3. Check the console for any Firebase-related errors

## Troubleshooting

### Firebase not initialized error:
- Make sure you've updated `lib/firebase_options.dart` with your actual configuration
- Check that all required files are in place (google-services.json, GoogleService-Info.plist)
- Verify your bundle ID/package name matches what you registered in Firebase

### Authentication not working:
- Ensure you've enabled the authentication methods in Firebase Console
- Check that your Firebase project is on the Blaze plan if you need certain features
- Verify your API keys are correct

### Platform-specific issues:
- For iOS: Make sure `GoogleService-Info.plist` is added to your Xcode project
- For Android: Ensure `google-services.json` is in `android/app/`
- For web: Check that the configuration is correct in `firebase_options.dart`

## Development vs Production

The app is designed to work in development mode even without Firebase configured. It will use a mock authentication repository when Firebase is not available, allowing you to develop and test the UI without setting up Firebase immediately.

When you're ready to deploy, make sure to:
1. Complete the Firebase setup above
2. Test authentication on all target platforms
3. Configure any additional Firebase services you need (Firestore, Storage, etc.) 