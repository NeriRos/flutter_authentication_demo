// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "appTitle": "Authentication",
  "login": "Login",
  "register": "Register",
  "email": "Email",
  "password": "Password",
  "confirmPassword": "Confirm password",
  "createAccount": "Create account",
  "alreadyHaveAccount": "Already have an account?",
  "signOut": "Sign out",
  "noUser": "No user found",
  "emailValidationMessage": "Enter your email",
  "passwordValidationMessage": "Enter your password {}"
};
static const Map<String,dynamic> he = {
  "appTitle": "התחברות",
  "login": "התחברות",
  "register": "הרשמה",
  "email": "אמייל",
  "password": "סיסמה",
  "confirmPassword": "אימות סיסמה",
  "createAccount": "יצירת חשבון",
  "alreadyHaveAccount": "כבר יש לך חשבון?",
  "signOut": "התנתקות",
  "noUser": "משתמש לא קיים",
  "emailValidationMessage": "הכנס אמייל תקין",
  "passwordValidationMessage": "הכנס סיסמה תקינה {}"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "he": he};
}
