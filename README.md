# Flutter Authentication Demo

Project that showcases authentication with Firebase and state management with Riverpod.

# THE EXERCISE

## OVERVIEW

The purpose of this exercise is to create a Flutter App (for mobile only), \
which allows a user to login with Firebase using Login with Apple and Google. \
A User State should be maintained using Riverpod. \
A matching unit-test should be implemented.

## REQUIREMENTS

- Create a Firebase project
- Create a login screen
- Allow a user to login with Apple or Google (both should be supported)
- Create a simple home screen with a Logout button
- Create a Nav Drawer with a button allowing to "switch language"
- Keep the user logged-in upon refresh (use Riverpod to maintain the user state)
- Create a unit-test for the login flow

## HOW TO DEVELOP

After editing locales use the following command:

```bash
flutter pub run easy_localization:generate -S assets/translations -O lib/generated -o codegen_loader.g.dart
flutter pub run easy_localization:generate -S assets/translations -O lib/generated -f keys -o locale_keys.g.dart
```