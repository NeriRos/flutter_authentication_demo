# Flutter Authentication Demo

Project that showcases authentication with Firebase and state management with Riverpod.

# THE EXERCISE

## OVERVIEW

The purpose of this exercise is to create a Flutter App (for mobile only), \
which allows a user to login with Firebase using Login with Apple and Google. \
A User State should be maintained using Riverpod. \
A matching unit-test should be implemented.

## REQUIREMENTS

1. [x] Create a Firebase project
2. [x] Create a login screen
3. [ ] Allow a user to login with Apple or Google (both should be supported)
4. [x] Create a simple home screen with a Logout button
5. [x] Create a Nav Drawer with a button allowing to "switch language"
6. [x] Keep the user logged-in upon refresh (use Riverpod to maintain the user state)
7. [ ] Create a unit-test for the login flow

# THE SOLUTION

## HOW TO DEVELOP

### Pre-requisites

- Flutter
- Dart
- Flutterfire CLI

### Locales

After editing locales use the following commands:

```bash
flutter pub run easy_localization:generate -S assets/translations -O lib/generated -o codegen_loader.g.dart
flutter pub run easy_localization:generate -S assets/translations -O lib/generated -f keys -o locale_keys.g.dart
```